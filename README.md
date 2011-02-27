# C-style enums for ruby

This project is an attempt to provide c-style enums for ruby. It's obviously impossible (and not even desirable) to capture the exact syntax and semantics of c's enums in a ruby implementation, but the major capabilities and usage patterns are supported.

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



