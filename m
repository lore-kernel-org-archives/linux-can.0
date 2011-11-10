From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: Problem with so Loved interrupts
Date: Thu, 10 Nov 2011 13:07:56 +0100
Message-ID: <4EBBBE9C.20007@grandegger.com>
References: <CAKvQZ_1Sf8xSJ2dGC7fO+mBFPQj_rwaeuiYcpJozUD0V5P1dYA@mail.gmail.com>	<CAKvQZ_0XOeaEqzXvC0L7YjBpQymeEhQvDJFwG2re7VTcTXLA3Q@mail.gmail.com>	<CAKvQZ_0RhjE3+OBLposEBoU8UL66_3JfV237bWnL5pR0HrRMVQ@mail.gmail.com>	<4EBB9EC1.1040508@grandegger.com> <CAKvQZ_06XxMmCzuu-3+moz12HHXcWOm1e3Jt4DuTZ1E=kGYjsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:59291 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932402Ab1KJMH6 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 10 Nov 2011 07:07:58 -0500
In-Reply-To: <CAKvQZ_06XxMmCzuu-3+moz12HHXcWOm1e3Jt4DuTZ1E=kGYjsQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Willy Lambert <lambert.willy@gmail.com>
Cc: linux-can@vger.kernel.org

On 11/10/2011 11:56 AM, Willy Lambert wrote:
> 2011/11/10 Wolfgang Grandegger <wg@grandegger.com>:
>> On 11/10/2011 09:56 AM, Willy Lambert wrote:
>>> 2011/11/9 Willy Lambert <lambert.willy@gmail.com>:
>>>> ---------- Forwarded message ----------
>>>> From: Willy Lambert <lambert.willy@gmail.com>
>>>> Date: 2011/11/9
>>>> Subject: Problem with so Loved interrupts
>>>> To: linux-can <linux-can@vger.kernel.org>
>>>>
>>>>
>>>> Hi all,
>>>> I am having interruption problems again.
>>>> The symptom is a /proc/interrupt or /proc/xenomia/irq not rising.
>>>> I am sure of my Hardware because I used an archive of a working linux
>>>> system and it works. So the wired are Ok, device is responding, BIOS
>>>> is well configured.
>>>> I check this : http://comments.gmane.org/gmane.network.socketcan.user/813,
>>>> and I am sure it is not the case since it worked with the old system
>>>> and it has been electrically protected.
>>>> I also recheck this
>>>> http://old.nabble.com/Re%3A-Trying-to-use-socketCan-on-an-Ixxat-PC-I-04-104-p30752686.html
>>>> but once again, everything is ok with old software.
>>
>> Please describe "old system" and "old software".
> 
> The system is a PC104 board with an Atom processor, on top of wich a
> CAN PC104 board is connected via the ISA bus. The sja1000 are acessed
> by iomem. With your help we did some Bios magics and some tunings to
> make it running. I currently have a fully working CAN bus with one
> device (and resistors...) that is configured at the rigth baudrate.
> This device has a led that change color with CAN NMT states, so I can
> easily see if a CAN message is going on the bus (with a 000#01.00 NMT
> request for instance).
> 
> The old system is a Debian 6.0.1 distibution with a custom 2.6.35.7
> built kernel with all that was required to make it working.
> The new one is the same debian with a custom 2.6.38.8 kernel with
> xenomai 2.6.0 patches.
> 
>>
>>>> So what did I changed ? I was updating many of my dependencies on my
>>>> target and even tried 64b, so the road have been very long. What I
>>>> accuse much is my new kernel. Before it was a 2.6.35.7, now it is a
>>>> 2.6.38.8 with xenomai patches. I may have forgot to select a kernel
>>>> option for interrupts...
>>
>> Well, you get other interrupts and therefore it seem to be specific to
>> the CAN hardware and the bus/slot it is connected to. You say that it
>> works with your 2.6.35.7 kernel but does not with 2.6.38.8 on the
>> *identical* hardware, right? Then I would check the kernel configs for
>> PNP related differences.
>>
> 
> The hardware and Bios are identical with last . I use clonezilla
> (http://clonezilla.org/clonezilla-live.php) to switch between the old
> archived filesystem and the new one.
> 
> I also seen something interesting on the new kernel system. I don't
> have interrupts but the first message goes on the bus ! Because the
> led of my device turn into the operationnal state afet a 000#01.00
> request (tested with xenomai driver). So the message goes, but the
> "ack" if any is not going back to the driver.
> 
> There is on difference on the interrupts type. Here is the old system
> 2.6.35.7 /proc/interrupts. Note that the type is IO-APIC
> root@beta:~# cat /proc/interrupts
>            CPU0
>   0:    5288851   IO-APIC-edge      timer
>   1:          4   IO-APIC-edge      i8042
>   8:          1   IO-APIC-edge      rtc0
>   9:          0   IO-APIC-fasteoi   acpi
>  10:          6   IO-APIC-edge      can0, can1
>  12:          7   IO-APIC-edge      i8042
>  14:          0   IO-APIC-edge      ata_piix
>  15:       3755   IO-APIC-edge      ata_piix
>  19:        232   IO-APIC-fasteoi   uhci_hcd:usb3
>  23:          2   IO-APIC-fasteoi   ehci_hcd:usb1, uhci_hcd:usb2
>  40:       4563   PCI-MSI-edge      eth0
> NMI:          0   Non-maskable interrupts
> LOC:       5406   Local timer interrupts
> SPU:          0   Spurious interrupts
> PMI:          0   Performance monitoring interrupts
> PND:          0   Performance pending work
> TRM:          0   Thermal event interrupts
> THR:          0   Threshold APIC interrupts
> MCE:          0   Machine check exceptions
> MCP:         18   Machine check polls
> ERR:          0
> MIS:          0

Can't tell where the difference comes from, sorry. You should first try
*without* Xenomai (and Xenomai patches) just to be sure that it's not
related to Xenomai. If if still doesn't work, please show use the
.config and /proc/modules of both setups (2.6.35 and 2.6.38).

Wolfgang.
