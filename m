From: Willy Lambert <lambert.willy@gmail.com>
Subject: Re: Problem with so Loved interrupts
Date: Mon, 14 Nov 2011 14:13:01 +0100
Message-ID: <CAKvQZ_3Xw0BW5gXnERUuDqRCB9TP8hCptLDiqO-n9vf8MCuNBw@mail.gmail.com>
References: <CAKvQZ_1Sf8xSJ2dGC7fO+mBFPQj_rwaeuiYcpJozUD0V5P1dYA@mail.gmail.com>
	<CAKvQZ_0XOeaEqzXvC0L7YjBpQymeEhQvDJFwG2re7VTcTXLA3Q@mail.gmail.com>
	<CAKvQZ_0RhjE3+OBLposEBoU8UL66_3JfV237bWnL5pR0HrRMVQ@mail.gmail.com>
	<4EBB9EC1.1040508@grandegger.com>
	<CAKvQZ_06XxMmCzuu-3+moz12HHXcWOm1e3Jt4DuTZ1E=kGYjsQ@mail.gmail.com>
	<4EBBBE9C.20007@grandegger.com>
	<CAKvQZ_1dTaT1OL2Q7TVxisL9Naqg5RDefDDooT-WjNZhzci=bQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:35420 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754549Ab1KNNND convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 14 Nov 2011 08:13:03 -0500
Received: by wwe5 with SMTP id 5so4354845wwe.1
        for <linux-can@vger.kernel.org>; Mon, 14 Nov 2011 05:13:01 -0800 (PST)
In-Reply-To: <CAKvQZ_1dTaT1OL2Q7TVxisL9Naqg5RDefDDooT-WjNZhzci=bQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org

2011/11/10 Willy Lambert <lambert.willy@gmail.com>:
> 2011/11/10 Wolfgang Grandegger <wg@grandegger.com>:
>> On 11/10/2011 11:56 AM, Willy Lambert wrote:
>>> 2011/11/10 Wolfgang Grandegger <wg@grandegger.com>:
>>>> On 11/10/2011 09:56 AM, Willy Lambert wrote:
>>>>> 2011/11/9 Willy Lambert <lambert.willy@gmail.com>:
>>>>>> ---------- Forwarded message ----------
>>>>>> From: Willy Lambert <lambert.willy@gmail.com>
>>>>>> Date: 2011/11/9
>>>>>> Subject: Problem with so Loved interrupts
>>>>>> To: linux-can <linux-can@vger.kernel.org>
>>>>>>
>>>>>>
>>>>>> Hi all,
>>>>>> I am having interruption problems again.
>>>>>> The symptom is a /proc/interrupt or /proc/xenomia/irq not rising=
=2E
>>>>>> I am sure of my Hardware because I used an archive of a working =
linux
>>>>>> system and it works. So the wired are Ok, device is responding, =
BIOS
>>>>>> is well configured.
>>>>>> I check this : http://comments.gmane.org/gmane.network.socketcan=
=2Euser/813,
>>>>>> and I am sure it is not the case since it worked with the old sy=
stem
>>>>>> and it has been electrically protected.
>>>>>> I also recheck this
>>>>>> http://old.nabble.com/Re%3A-Trying-to-use-socketCan-on-an-Ixxat-=
PC-I-04-104-p30752686.html
>>>>>> but once again, everything is ok with old software.
>>>>
>>>> Please describe "old system" and "old software".
>>>
>>> The system is a PC104 board with an Atom processor, on top of wich =
a
>>> CAN PC104 board is connected via the ISA bus. The sja1000 are acess=
ed
>>> by iomem. With your help we did some Bios magics and some tunings t=
o
>>> make it running. I currently have a fully working CAN bus with one
>>> device (and resistors...) that is configured at the rigth baudrate.
>>> This device has a led that change color with CAN NMT states, so I c=
an
>>> easily see if a CAN message is going on the bus (with a 000#01.00 N=
MT
>>> request for instance).
>>>
>>> The old system is a Debian 6.0.1 distibution with a custom 2.6.35.7
>>> built kernel with all that was required to make it working.
>>> The new one is the same debian with a custom 2.6.38.8 kernel with
>>> xenomai 2.6.0 patches.
>>>
>>>>
>>>>>> So what did I changed ? I was updating many of my dependencies o=
n my
>>>>>> target and even tried 64b, so the road have been very long. What=
 I
>>>>>> accuse much is my new kernel. Before it was a 2.6.35.7, now it i=
s a
>>>>>> 2.6.38.8 with xenomai patches. I may have forgot to select a ker=
nel
>>>>>> option for interrupts...
>>>>
>>>> Well, you get other interrupts and therefore it seem to be specifi=
c to
>>>> the CAN hardware and the bus/slot it is connected to. You say that=
 it
>>>> works with your 2.6.35.7 kernel but does not with 2.6.38.8 on the
>>>> *identical* hardware, right? Then I would check the kernel configs=
 for
>>>> PNP related differences.
>>>>
>>>
>>> The hardware and Bios are identical with last . I use clonezilla
>>> (http://clonezilla.org/clonezilla-live.php) to switch between the o=
ld
>>> archived filesystem and the new one.
>>>
>>> I also seen something interesting on the new kernel system. I don't
>>> have interrupts but the first message goes on the bus ! Because the
>>> led of my device turn into the operationnal state afet a 000#01.00
>>> request (tested with xenomai driver). So the message goes, but the
>>> "ack" if any is not going back to the driver.
>>>
>>> There is on difference on the interrupts type. Here is the old syst=
em
>>> 2.6.35.7 /proc/interrupts. Note that the type is IO-APIC
>>> root@beta:~# cat /proc/interrupts
>>> =A0 =A0 =A0 =A0 =A0 =A0CPU0
>>> =A0 0: =A0 =A05288851 =A0 IO-APIC-edge =A0 =A0 =A0timer
>>> =A0 1: =A0 =A0 =A0 =A0 =A04 =A0 IO-APIC-edge =A0 =A0 =A0i8042
>>> =A0 8: =A0 =A0 =A0 =A0 =A01 =A0 IO-APIC-edge =A0 =A0 =A0rtc0
>>> =A0 9: =A0 =A0 =A0 =A0 =A00 =A0 IO-APIC-fasteoi =A0 acpi
>>> =A010: =A0 =A0 =A0 =A0 =A06 =A0 IO-APIC-edge =A0 =A0 =A0can0, can1
>>> =A012: =A0 =A0 =A0 =A0 =A07 =A0 IO-APIC-edge =A0 =A0 =A0i8042
>>> =A014: =A0 =A0 =A0 =A0 =A00 =A0 IO-APIC-edge =A0 =A0 =A0ata_piix
>>> =A015: =A0 =A0 =A0 3755 =A0 IO-APIC-edge =A0 =A0 =A0ata_piix
>>> =A019: =A0 =A0 =A0 =A0232 =A0 IO-APIC-fasteoi =A0 uhci_hcd:usb3
>>> =A023: =A0 =A0 =A0 =A0 =A02 =A0 IO-APIC-fasteoi =A0 ehci_hcd:usb1, =
uhci_hcd:usb2
>>> =A040: =A0 =A0 =A0 4563 =A0 PCI-MSI-edge =A0 =A0 =A0eth0
>>> NMI: =A0 =A0 =A0 =A0 =A00 =A0 Non-maskable interrupts
>>> LOC: =A0 =A0 =A0 5406 =A0 Local timer interrupts
>>> SPU: =A0 =A0 =A0 =A0 =A00 =A0 Spurious interrupts
>>> PMI: =A0 =A0 =A0 =A0 =A00 =A0 Performance monitoring interrupts
>>> PND: =A0 =A0 =A0 =A0 =A00 =A0 Performance pending work
>>> TRM: =A0 =A0 =A0 =A0 =A00 =A0 Thermal event interrupts
>>> THR: =A0 =A0 =A0 =A0 =A00 =A0 Threshold APIC interrupts
>>> MCE: =A0 =A0 =A0 =A0 =A00 =A0 Machine check exceptions
>>> MCP: =A0 =A0 =A0 =A0 18 =A0 Machine check polls
>>> ERR: =A0 =A0 =A0 =A0 =A00
>>> MIS: =A0 =A0 =A0 =A0 =A00
>>
>> Can't tell where the difference comes from, sorry. You should first =
try
>> *without* Xenomai (and Xenomai patches) just to be sure that it's no=
t
>> related to Xenomai. If if still doesn't work, please show use the
>> .config and /proc/modules of both setups (2.6.35 and 2.6.38).
>>
>
> My non working 2.6.38.8 was built from the default Debian .config fil=
e
> with many options included and an initrd. I didn't came from 2.5.37.5
> because for some reason I had a kernel boot panic because of
> filesystem/disk driver modules. But I managed to find the right optio
> today.
>
> With a fresh 2.6.38.8 made from the 2.6.35.7 .config file with make
> oldconfig, installed on the old system =A0it works ! And I still have
> IO-APIC-edge interrupts. =A0I also made a try adding xenomai with
> success. For completeness I tested this ligth 2.6.38.8 kernel on the
> "new" filesystem in place of the faulty 2.6.38.8 kernel and everythin=
g
> seems OK.
>
> The IRQ type differences must be due to kernel configurations (my
> faulty big 2.6.38.8 one and my working-now ligth 2.6.38.8 from
> 2.5.35.7).
> I prefere using the light kernel version that's now working so I don'=
t
> mind giving up with debugging this problem. If you are interested in
> finding what's happening let me know.
>
>
>
> I'll do my personnal functionnal tests and I'll try the platform
> driver. Thanks for help.
>

=46YI some kernel configs that may be linked to the problem are :

=95	Bus options (PCI etc.) ->Interrupts on hypertransports devices
=95	Processor type and features ->Local APIC support on uniprocessors
=95	Processor type and features ->IO-APIC support on uniprocessors
=95	Bus options (PCI etc.) ->PCI IOV Support

I can't spend more time now on it to really find the one that is
responsible of this IRQ type change



>> Wolfgang.
>>
>
