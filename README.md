# C-style enums for ruby

This project is an attempt to provide c-style enums for ruby. It's obviously impossible (and not even desirable) to capture the exact syntax and semantics of c's enums in a ruby implementation, but the major capabilities and usage patterns are supported.

## Basic Usage

    require 'cenum.rb'

    class PetOwner
      
      ANIMALS = enum :cat, :dog, :monkey

      def initialize(animal)
        self.animal = animal || ANIMALS::Dog
      end

    end

    zoologist = PetOwner.new(ANIMALS::Monkey)

## Features

