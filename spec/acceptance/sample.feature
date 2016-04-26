Feature: Attacking a monster
  Background:
    Given there is a monster

  Scenario: attack the monster
    When I wait 1 seconds
    Then it should die
    Then I wait 1 seconds
