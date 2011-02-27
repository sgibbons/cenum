# C-style enums for ruby

This project is an attempt to provide c-style enums for ruby. It's obviously impossible (and not even desirable) to capture the exact syntax and semantics of c's enums in a ruby implementation, but the major capabilities and usage patterns are supported.

## But ruby has symbols, why do we need enums?

Symbols are great. You should probably keep on using symbols in most of the places that you currently do. There are, however, certain situations that enums are better suited for. For instance:

  * A variable can take on a finite set of known, named, values.
  > The set of values that a variable can take on define that variable's type. Rather than just scattering symbols throughout your code that modifes the variable, it is frequently helpful to encapsulate the type information in one place. An enum, being a lightweight, in-line class definition, is an ideal place to do this. Examples of this type of situation would be when you need to represent days-of-the-week or drink sizes available
        DAY_OF_WEEK = enum :sun, :mon, :tues, :wed, :thurs, :fri, :sat
        DRINK_SIZE = enum :small, :medium, :large
  * A dual name/value representation is needed. This is particularly common when you have a set of possible values with an inherent ordering.
  > Enums have the property of defining both names and values, so you can sometimes get the best of both worlds by using them.
        DRINK_SIZE = enum :small, :medium, :large
        DRINK_SIZE::SMALL < DRINK_SIZE::LARGE  # true

## Basic Usage

    require 'cenum.rb'

    class PetOwner

      ANIMALS = enum :cat, :dog, :bird

      def initialize(animal)
        @animal = animal || ANIMALS::DOG
      end

      def pet_says
        case @animal
          when ANIMALS::CAT then 'meow'
          when ANIMALS::DOG then 'woof'
          when ANIMALS::BIRD then 'tweet'
        end
      end

    end

    bird_owner = PetOwner.new(PetOwner::ANIMALS::Bird)

    bird_owner.pet_says  # 'tweet'

## Features

  * Enum values map to integers

        irb> DIRECTIONS = enum :up, :down, :left, :right
        irb> DIRECTIONS::UP
        0
        irb> DIRECTIONS::DOWN
        1

  * Enum declaration is type declaration

        irb> Boolean = enum :true, :false
        irb> yes = Boolean.new(:true)
        irb> no = Boolean.new(:false)
        irb> yes == no
        false

  * Value checks and mutators generated automatically

        irb> Boolean = enum :true, :false
        irb> yes = Boolean.new(:true)
        irb> no = Boolean.new(:false)
        irb> yes.true?
        true
        irb> no.true?
        false
        irb> maybe = Boolean.new(:true)
        irb> maybe == yes
        true
        irb> maybe.false!
        irb> maybe == yes
        false
        irb> maybe == no
        true

  * Direct comparison of type instances with value names

        irb> Boolean = enum :true, :false
        irb> yes = Boolean.new(:true)
        irb> yes == Boolean::TRUE
        true
        irb> yes != Boolean::FALSE
        true

  * Values can be compared

        irb> up = DIRECTIONS.new(:up)
        irb> down = DIRECTIONS.new(:down)
        irb> up < down
        true

## Roadmap

  * Custom value mappings, like c's:

        enum DAY { saturday, sunday = 0, monday, tuesday, ... etc }
