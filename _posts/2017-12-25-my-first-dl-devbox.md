---
layout: post
title:  "my_first_deeplearning_devbox"
date: 2017-12-25
comments: true
categories: misc
---
I recently decided that my 2018 New Years resolution would be to up my game in
deep/reinforcement learning research and implementation. And after lots of research
and pondering, I concluded that it'd be best to have my very own development box.
Having never built a computer ever in my life before, this exercise was filled with all
sorts of emotions, such as excitement, anxiety, stress (e.g., don't f**k this up),
and pure joy! But at the end of the day, I can honestly say that this has been
one of the most gratifying experiences in my life to date -- in fact; I am writing
this post on my very new dev machine, and it feels amazing!

### The Specs
The hardware for my machine was mainly inspired by Roelof Pieters' custom build, which he wrote
about [here](http://graphific.github.io/posts/building-a-deep-learning-dream-machine/).
I did however make some of my own modifications to Roelof's machine (e.g., GPU choice,
and number of HDDs and SSDs). I also found [Tim Dettmers' blog](http://timdettmers.com/2017/04/09/which-gpu-for-deep-learning/) to be a valuable
source of knowledge throughout this process. Below are the specs that I landed on:

1. CPU - intel i7-5930k 3.5GHz
2. 1x GPU - ASUS ROG Strix GeForce GTX 1080 Ti 11GB
3. Motherboard - ASUS X99-E WS
4. RAM - Kingston Technology 32GB (4x8GB)
5. SSD - Samsung 850 EVO 250GB
6. HDD - WD 3 TB NAS Hard Drive
7. Chassis - Corsair Carbide Series Air 540 High Airflow
8. Power Supply -  Corsair AX1500i 1500W
9. CPU Cooler - Corsair Hydro Series H115i

*I hope to add some upgrades when the need for them arises. In particular, my CPU
can take up to 64GB of RAM, and it would be pretty badass to add another one or two of
those 1080Ti GPU thingys.*

### The Build
Fortunately for me, I had some help in the actual building of this machine from
my best friend, Lorenzo; BUT, he never built a computer before either, so there's that...

![example]({{site.url}}/images/boxes.jpg)

![example]({{site.url}}/images/gpu.jpg)

![example]({{site.url}}/images/install_cpu.jpg)

![example]({{site.url}}/images/cpugpu.jpg)

![example]({{site.url}}/images/case.jpg)

![example]({{site.url}}/images/final.jpg)

#### Some difficulties we encountered...
Here is a list of some of the difficulties we encountered during the build
process:
1. Massive amount of cables -- e.g., figuring out what a SATA power cable is (lol)
and where all the components connect.
2. When it came to powering on the machine, everything was working but we were
getting an error message saying to plug the GPU into a power supply. Not sure if
this applies to all NVIDIA GPUs, but the ASUS ROG Strix comes with two auxiliary
power supplies. Initially we only had one power supply connected, but after connecting
the other one, the error message went away.
3. One of the four memory chips were not set in place properly. During initial boot,
the motherboard was only recognizing 24GB of the 32GB total RAM. We fixed this by finding the culprit
memory chip and reinstalling it.

**Total Build Time:** Aproximately 5 hours with a 30 minute pizza/beer break (I think that's pretty good
for a couple of noobies -- I wonder how long this would have taken without the
ability to look things up on the internet!)

### Installing Ubuntu 16.0.4
I opted to install Ubuntu 16.0.4 after some research, where I found out about LTS
versions. Also, the guide for installing the CUDA toolkit, which I plan to follow, is also
based on Ubuntu 16.0.4. I've installed Ubuntu just one time before this, but
after seeing both the black/purple screen of deaths, I was quickly reminded of the
pain & struggles I went through the first time. In total, it took me about 1.5 hours
to get Ubuntu up and running on this machine, but it was still a mildly frustrating
process. Here is what I had to do to get past the black/purple screens of death:

1. To get past the black screen of death during installation: Go into GRUB menu,
highlight "Ubuntu", press "c", remove "quiet" and "splash" and replace with "nomodeset".
2. After successful installation, I was seeing the purple screen of death because
of misconfiguration with my GPU. To get past this purple screen of death, I had to
reboot into the GRUB menu (by holding "SHIFT" during initial boot), and follow the
steps listed [here](https://askubuntu.com/questions/760934/graphics-issues-after-while-installing-ubuntu-16-04-16-10-with-nvidia-graphics) under 3. I then followed steps 1. and 2. in that same link to
install the correct NVIDIA drivers (note that I installed `nvidia-381`).

I also want to mention that I installed Ubuntu onto my SSD and am just using the HDD
([after formatting](https://www.wikihow.com/Format-a-Hard-Drive-Using-Ubuntu#/Image:Format-a-Hard-Drive-Using-Ubuntu-Step-6-Version-3.jpg))
for file storage. Not sure if this is the best setup (I did
come across some more complicated boot setups), but I opted for the most basic one
for now. Finally, I did also experience scratchy/distorted sound at first, but
I followed the steps listed in this [Ubuntu wiki](https://help.ubuntu.com/community/SoundTroubleshootingProcedure) and that
solved my sound problems!

### What's Next
1. Install CUDA toolkit and other tools for deep learning. I will follow [this guide](https://www.pyimagesearch.com/2017/09/27/setting-up-ubuntu-16-04-cuda-gpu-for-deep-learning-with-python/) by Adrian Rosebrock.
2. Train some DL algorithms -- super excited to train some ConvNets, CapsNets, RNNs,
LSTMs in the coming year!
