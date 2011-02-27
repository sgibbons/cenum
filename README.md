# C-style enums for ruby

This project is an attempt to provide c-style enums for ruby. It's obviously impossible (and not even desirable) to capture the exact syntax and semantics of c's enums in a ruby implementation, but the major capabilities and usage patterns are supported.

## But ruby has symbols, why do we need enums?

Symbols are great. You should probably keep on using symbols in most of the places that you currently do. There are, however, certain situations that enums are better suited for. For instance:

  * A variable can take on a finite set of known, named, values.
  > The set of values that a variable can take on define that variable's type. Rather than just scattering symbols throughout your code that modifes the variable, it is frequently helpful to encapsulate the type information in one place. An enum, being a lightweight, in-line class definition, is an ideal place to do this. Examples of this type of situation would be when you need to represent days-of-the-week or drink sizes available
        DAY_OF_WEEK = enum :sun, :mon, :tues, :wed, :thurs, :fri, :say
        DRINK_SIZE = enum :small, :medium, :large
  * A dual name/value represantation is need. This is particularly common when you have a set of possible values with an inherent ordering.
  > Enums have the property of defining both names and values, so you can sometimes get the best of both worlds by using them.
        DRINK_SIZE = enum :small, :medium, :large
        DRINK_SIZE::Small < DRINK_SIZE::Large  # true

## Basic Usage

    require 'cenum.rb'

    class PetOwner
      
      ANIMALS = enum :cat, :dog, :bird

      def initialize(animal)
        @animal = animal || ANIMALS::Dog
      end

      def pet_says
        case @animal
          when ANIMALS::Cat then 'meow'
          when ANIMALS::Dog then 'woof'
          when ANIMALS::Bird then 'tweet'
        end
      end

    end

    bird_owner = PetOwner.new(PetOwner::ANIMALS::Bird)

    bird_owner.pet_says  # 'tweet'

## Features

  * Enum values map to integers
        
        irb> DIRECTIONS = enum :up, :down, :left, :right
        irb> DIRECTIONS::Up
        0
        irb> DIRECTIONS::Down
        1

  * Enum declaration is type declaration

        irb> Boolean = enum :true, :false
        irb> yes = Boolean.new(:true)
        irb> no = Boolean.new(:false)
        irb> yes == no
        false
        irb> yes.true?
        true
        irb> false.true?
        false
        irb> maybe = Boolean.new(:true)
        irb> maybe == yes
        true
        irb> maybe.false!
        irb> maybe == yes
        false
        irb> maybe == no
        true

## Roadmap

  * Custom value mappings, like c's:
        
        enum DAY { saturday, sunday = 0, monday, tuesday, ... etc }

  * Comparisons between named values and type instances:

        irb> Boolean = enum :true, :false
        irb> yes = Boolean.new(:true)
        irb> yes == Boolean::True  # not currently supported
        true



