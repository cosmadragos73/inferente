# SCons condensed readme

This document should act as a minimal guide on how we should treat SCons usage so we dont have to read the entiire ----ing manual.

The entire manual can be found in two places, why? : because two is better
    [two](http://www.scons.org/doc/HTML/scons-man.html) 
    [documents](http://www.scons.org/doc/2.3.0/HTML/scons-user/index.html)


## Basic concepts

SCons starts by reading through the SConstruct and all the SConcript.
    It builds a dependeny tree before actually creating anything (artifacts, folders, etc...)
    When writing build steps, do the scons-y or scons-x thing we have to make sure the work is done at depedency tree EXECTUION time ( and not dependency tree creation time)
When using built-in builders, SCons documentation says that they are all "available" out of the box. IF we find one that throws an error when it is used, it is mostly a problem in "your" (our) SCons source tree, but no on the environment. 


## Basic Components

### Builders

Full documentation:
    Builder methods [here][Builder Methods], 
    Builder objects [here][Builder Objects], 
    Command "Builder"[here][Command], 
    Writing custom Builders [here][Writing Your Own Builders]

What are Builders?
Essentialy they are compile steps:
    they take a source (or list of sources) and produce a target (it can be modified to do multiple steps but one target is neccesary in order not to overengineer things)
A Builder has an "Action" associated with it that should do all the work of creating the target
    The "Action" will happen only if SCons decides it's needed to resolve a dependency.

A Builder accepts custom Envrionment overrwrites (overrides?)
    If we build three different binaries in a SConscript, there shall be no need for three different Environments or cloning the Environment multiple times for each binary.


Example:

    env.Append(CCFLAGS=common_flags)
    env.MovidiusProgram('HelloWorld', helloWorld_sources, LIBS=helloWorld_libs)
    env.Program(target = 'test', source = [test_sources, test_another_thing_sources],     LIBS=ping_libs)

**[Custom Builders][Writing Your Own Builders]**

A custom builder can be created in a few ways:

we can create our "Action" function that should always have this 3 arguments (target, source, env)

def custom_build_function(target, source, env):
    # Write code that tells how to create "target" from source
        if succes:
            return 0 or None #(SCons standard custom action exist code if correct build)
        else:
            return (custom function?)
            or
            RaiseExcepton("MyException")
    #Acutally creating our build.
    my_custom_builder = SCons.Builder.Builder(action = custom_build_function)

or we can create a builder with evaulation at SConscrip level ( i did not really play with this because yes... and because it's pretty hard to debug 
    given the fact that you can have many SConscript with different settings that could call the same builder with different commands)

    my_custom_builder(action = '<my_external_command> $VARIABLE $SOURCE ${TARGET.file}')
 
or we can create a builder with action at the dependency tree exectuion ( called Builders that create actions using a generator function) 
which takes in a new argument:
    "for_signature"
        A flag that specifies whether the generator is being called to contribute to a build signature, as opposed to actually executing the command.


    def my_custom_generator_function(target, source, env, for_signature):
        return '<my_external_command> {} {} {}'.format(env.variable, source[0], target.abspath)
    my_custom_builder = SCons.Builder.Builder(generator = my_custom_generator_function)


the final step is to add the builder to the environment by appending it to the BUILDERS key with a name and a value:
    env.Append(BUILDERS={'MyNewBuilder': my_custom_builder})
or
    env['BUILDERS']['MyNewBuilder'] = _my_custom_builder

**Emitters**

An emitter is a python function that allows us to modify the targets and sources based on the environment:

    def my_custom_emmiter_function(target, source, env):
        #Write code that will change target or source 
            # or create a new build_list with this
I have not yet found a very good reason to create emitters without a clear scope,
We can use this emitters to change the default SCons builders behaviour given a set of sources and targets.

For example StaticLibrary(target = 'my_static_library', source=['my_lib_sources], env.FLAGS='my_custom_flags' IF NOT SET )
    What SCons will do is, will see if the source files need to be compiled by looking at the source file extension.. (for sainy lets remain on C-objects)
        If the source object is not built it will build the source object before createing the static_library
        If the source object is built it will just add it in the target and not rebuild it
#All of this is considering the compilation flags do not change


### Methods

Methods, and what we moslty use, are just python functions that are added to an environment by using env.AddMethod

They are good for grouping calls to builder, adding on the fly modifications to the construction environment, customizing + abstraction on our
 build steps

def my_custom_method(env, whatArgumentsDoYouNeeed):
    #Code to modify environment
        #and
    #Call a builder
env.AddMethod(my_custom_method, 'NewMethodThatNoOneKnowsHowToUse')

allowing for a later call:
    env.NewMethodThatNoOneKnowsHowToUse(my arguments are not correct)

### Actions

Actions documentation can be found here [here][Action Objects]

Actions basically represent a thing that has to be done.
    They can be made to happen at dependency tree building by using "Execute" (scons built-in)
or
    They can be delayed to happen at dependey tree exectuion by warpping them in a Builder call.

To note is that:
    The type of object passed to action determines how the action is created:

        e.g: Action( ['cc', '$TARGET', '$SOURCE'] ) 

    would create three actions, one for each element in the list.
    
    while:
        e.g: Action( [ ['cc', '$TARGET', '$SOURCE' ] ] )
    or 
        e.g: Action('cc $TARGET $SOURCE')
    would just do the right thing



### Scanners

Full documentation of scanners can be found:
    Scanner Objects[here][Scanner Objects] 
    Writing Scanners [here][Writing Scanners]

Scanners look at the contents of files and create dependnecies based on the information found. 
    my_file.c:1 
        #1include "my_included_header.h"
        #include <my_header.h>
    
    SCons will now know that my_file.c depends:
         on "my_included_header.h
    and
        on "my_header.h"

If anyone wants to mess with these, read the documentantion because they choke on some stuff...but they can be extented


## Variable Substitution & Construction Variable Expansion

Construction Variables [here][Construction Variables]
Construction Environments [here][Construction Environments]
Variable Substituion [here][Variable Substitution]
Python Code Substition  [here][Python Code Substitution]

SCons has support for variables substituion in many strings, and in those that recall being a COMMAND:
    if we want to manually do a substitution on a string we use the [subst] method, which will recursively expand a string 

We can use curly braces to separate a variable from other characters:
        '${TARGET}_some_output'
We can also acces attributes of the "thing" that will get replaced:
        '${THING_TO_REPLACE.someAttribute}
        '${THING_TO_REPLACE[0]}'

As far as i know the code between ${and} is run through python eval, so comparation and ternary operators should be valid?

When we call a top-level SCons function:
    Action,Builder
anything that we expect to be expaned will be expaned when that specific Action, Builder is actually called
#!NOTE if we do env.Action, env.Builder, variables expansion happens instant

### In an Action/Command (Variable Substitution)

The following variables are reserved and should no be explicity set:
     `$SOURCE`, `$SOURCES`, `$CHANGED_SOURCES`, `$UNCHANGED_SOURCES`, `$TARGET`, `$TARGETS`, `$CHANGED_TARGETS`, and `$UNCHANGED_TARGETS`
They also have certain attributes we can acces, the most useful of which are:
    `file`, `abspath`, and `suffix` as well as things like `srcpath` and `srcdir`, which will give the version of the file in the variant dir.
More can be found in the Variable Substituion documentation

## Non-file Dependencies
All SCons Dependencies are handled via nodes in the dependency tree.
    There are File,Dir, Value Nodes ( did i miss something?)
File, Dir are acctualy SCons built-in methods that allows the cross platform functionaly, given the fact that we have multiple dirs with different paths in multiple OS's

The Dir method, allows us to specify that the given string is a Dir platoform-independenlty 
The FIle method is the same.. just for Files

Value Nodes, let the programmer do dependencies on non-file things
e.g:
    #Create Environment
    env = Environment()
    value_to_node = env.Value('test')
    command_to_execute = env.Coomand('my_target_file.txt', 'my_input_file.txt', 'type $SOURCE > $TARGET')
    env.Depends(command_to_execute, value)

[Action Objects]: http://www.scons.org/doc/HTML/scons-man.html#lbAQ
[Builder Methods]: http://www.scons.org/doc/HTML/scons-man.html#lbAH
[Builder Objects]: http://www.scons.org/doc/HTML/scons-man.html#lbAP
[Writing Your Own Builders]: http://www.scons.org/doc/2.3.0/HTML/scons-user/c3621.html
[Command]: http://www.scons.org/doc/2.3.0/HTML/scons-user/c3895.html
[Construction Environments]: http://www.scons.org/doc/2.3.0/HTML/scons-user/x1444.html
[Construction Variables]: http://www.scons.org/doc/HTML/scons-man.html#lbAK
[Variable Substitution]: http://www.scons.org/doc/HTML/scons-man.html#lbAS
[Python Code Substitution]: http://www.scons.org/doc/HTML/scons-man.html#lbAT
[Execute]: http://www.scons.org/doc/2.3.0/HTML/scons-user/x3095.html
[subst]: http://www.scons.org/doc/2.3.0/HTML/scons-user/x1444.html#AEN1498
[Scanner Objects]: http://www.scons.org/doc/HTML/scons-man.html#lbAU
[Writing Scanners]: http://www.scons.org/doc/2.3.0/HTML/scons-user/c3966.html