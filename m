From: Michael Pellegrini <mikep86@gmail.com>
Subject: Re: =?utf-8?b?cGNoX2Nhbjo=?= Data transmission stops after dropped packet
Date: Mon, 19 Nov 2012 15:10:46 +0000 (UTC)
Message-ID: <loom.20121119T155735-163@post.gmane.org>
References: <loom.20121114T160521-534@post.gmane.org> <50A4972A.9070707@hartkopp.net> <50A4EA87.9020206@grandegger.com> <loom.20121115T171319-854@post.gmane.org> <50A55C65.2020003@grandegger.com> <loom.20121115T222748-977@post.gmane.org> <50A95FC1.3050907@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:58039 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752947Ab2KSPLH (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 19 Nov 2012 10:11:07 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1TaT0C-0004LI-Tb
	for linux-can@vger.kernel.org; Mon, 19 Nov 2012 16:11:13 +0100
Received: from 96.45.208.254 ([96.45.208.254])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Mon, 19 Nov 2012 16:11:12 +0100
Received: from mikep86 by 96.45.208.254 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Mon, 19 Nov 2012 16:11:12 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Wolfgang Grandegger <wg <at> grandegger.com> writes:

> 
> On 11/15/2012 10:34 PM, Michael Pellegrini wrote:
> > Wolfgang Grandegger <wg <at> grandegger.com> writes:
> > 
> >> I need to check first if this driver can be supported with little effort.
> > 
> > Thank you for your consideration.
> 
> For simple out-of-tree build I have now extracted the most recent
> version of c_can and c_can_pci driver files, backported it to v3.2 and
> added the PCH related code.
> 
> You should be able to build these drivers on your system as shown below:
> 
>   $ tar xf c-can-pci-v1.tar.bz2
>   $ cd c-can-pci-v1
>   $ CONFIG_CAN_C_CAN_PCI=m \
>     make -C /usr/src/linux-headers-`uname -r` SUBDIRS=`pwd` modules
> 
> This requires that you have the kernel header, gcc and fiends installed
> on your system.
> 
> Then you can load the modules as shown below, after unloading the
> original C_CAN modules:
> 
>   $ sudo modprobe can_dev
>   $ rmmod c_can
>   $ rmmod c_can_pci
>   $ sudo insmod c_can.ko
>   $ sudo insmod c_can_pci.ko
> 
> Hope it works as expected. 

I got the modules built, however loading them results in a non-functional CAN 
interface.  can0 no longer shows up in "ifconfig" or "ip".  Upon loading the 
modules, dmesg prints the following:

[ 2786.244341] c_can_pci 0000:02:0c.3: PCI INT C -> GSI 18 (level, low) -> IRQ 
18
[ 2786.244381] c_can_pci 0000:02:0c.3: setting latency timer to 64
[ 2786.244497] c_can_pci 0000:02:0c.3: irq 41 for MSI/MSI-X
[ 2786.244523] c_can_pci 0000:02:0c.3: device has no PCI memory resources, 
failing adapter
[ 2786.244586] c_can_pci 0000:02:0c.3: PCI INT C disabled
[ 2786.244611] c_can_pci: probe of 0000:02:0c.3 failed with error -12

To load the modules, I executed the following commands:

sudo rmmod c_can
sudo rmmod pch_can
sudo insmod ./c_can.ko
sudo insmod ./c_can_pci.ko

After loading the modules, lsmod outputs the following:

Module                  Size  Used by
c_can_pci              13009  0
c_can                  17867  1 c_can_pci
can_raw                12864  0
can                    27623  1 can_raw
i2c_isch               12662  0
snd_hda_codec_realtek   174055  1
snd_hda_intel          32765  3
snd_hda_codec         109562  2 snd_hda_codec_realtek,snd_hda_intel
snd_hwdep              13276  1 snd_hda_codec
snd_pcm                80845  2 snd_hda_intel,snd_hda_codec
snd_seq_midi           13132  0
snd_rawmidi            25424  1 snd_seq_midi
snd_seq_midi_event     14475  1 snd_seq_midi
snd_seq                51567  2 snd_seq_midi,snd_seq_midi_event
snd_timer              28931  2 snd_pcm,snd_seq
snd_seq_device         14172  3 snd_seq_midi,snd_rawmidi,snd_seq
snd                    62064  15 
snd_hda_codec_realtek,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_rawmidi,
snd_seq,snd_timer,snd_seq_device
soundcore              14635  1 snd
snd_page_alloc         14108  2 snd_hda_intel,snd_pcm
lpc_sch                12720  0
ftdi_sio               35859  0
usbserial              37173  1 ftdi_sio
can_dev                14748  1 c_can
bnep                   17830  2
rfcomm                 38139  0
bluetooth             158438  10 bnep,rfcomm
parport_pc             32114  0
ppdev                  12849  0
video                  19068  0
mac_hid                13077  0
pch_phub               13207  0
gpio_pch               13126  0
shpchp                 32325  0
lp                     17455  0
parport                40930  3 parport_pc,ppdev,lp
sdhci_pci              18324  0
sdhci                  28241  1 sdhci_pci
pch_gbe                38415  0

Is there anything else I should try, or do you have to make changes on your end?

Thanks,
Mike

