# Planning your Yosemite hikes

Yosemite National Park is so popular that the trailheads have quotas. 

The National Parks Service keeps [a list of full trailheads](https://www.nps.gov/yose/planyourvisit/fulltrailheads.htm) that you can use to determine where there's space for you and your party. This script helps you navigate that page.

# How to use this

Clone it to your computer and install the Ruby gem dependencies with this:
```
git clone https://github.com/JackDanger/yosemite.git
cd yosemite
bundle
```

Then find a trailhead that works for you:
```
bundle exec ruby trailhead_availability.rb 2019-09-09 2019-09-13
```

Example output:

    Found 25/44 available trailheads
      Beehive Meadows
      Bridalveil Creek
      Budd Creek (cross-country only)
      Chilnualna Falls
      Glacier Point->Illilouette
      Happy Isles->Illilouette
      Kibbie/USFS
      Luken->Lukens Lake
      Lukens Lake->Yosemite Creek
      McGurk  Meadow
      Miguel Meadow
      Mirror Lake->Snow Creek
      Mono/Parker Pass
      Nelson  Lake
      Ostrander (Lost Bear Meadow)
      Pohono Trail (Glacier Point)
      Pohono Trail (Taft Point)
      Pohono Trail (Wawona Tunnel/Bridalveil Parking)
      Porcupine Creek
      Rancheria Falls
      Rockslides
      Tamarack Creek
      White Wolf->Smith Meadow (including Harden Lake)
      Yosemite Creek
      Yosemite Falls
