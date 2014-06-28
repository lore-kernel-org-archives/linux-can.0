From: Austin Schuh <austin@peloton-tech.com>
Subject: Re: Bus off
Date: Sat, 28 Jun 2014 11:48:38 -0700
Message-ID: <CANGgnMZ2Xk=24thCrfHs4QSBPNJ_SfD41HXEATsrr3pd==JOKA@mail.gmail.com>
References: <CANGgnMZyG1UDVigM-68tu27=oNYfaw0OWxCv4uT+NfN4v=vm2A@mail.gmail.com>
 <20140627050512.GA1291@vandijck-laurijssen.be> <OF8D65BB4D.F92B928C-ON86257D04.00546246-86257D04.0054697F@notes.cat.com>
 <53AD8F4B.7090900@grandegger.com> <OF5172F7FC.3EFFF9B4-ON86257D04.0056582A-86257D04.00568EC9@notes.cat.com>
 <53AD9BA1.1030801@grandegger.com> <53ADAB2F.5030902@hartkopp.net>
 <CANGgnMbyLN0C-dmGOv8Qyo05jXSFxK81iNuqLTK2a4wo9CfzYg@mail.gmail.com> <53AE8245.7080005@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:54105 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756059AbaF1Ss7 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 28 Jun 2014 14:48:59 -0400
Received: by mail-ig0-f178.google.com with SMTP id hn18so3033619igb.5
        for <linux-can@vger.kernel.org>; Sat, 28 Jun 2014 11:48:58 -0700 (PDT)
In-Reply-To: <53AE8245.7080005@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Jason R1 White <White_Jason_R1@cat.com>, linux-can@vger.kernel.org, linux-can-owner <linux-can-owner@vger.kernel.org>

On Sat, Jun 28, 2014 at 1:52 AM, Wolfgang Grandegger <wg@grandegger.com> wrote:
> On 06/28/2014 03:29 AM, Austin Schuh wrote:
>> Thanks everyone!  Reading this thread has been very informative.  I
>> was hoping that the buffers would get flushed on BUS_OFF, but it
>> sounds like that is hard to do.
>>
>> I'm not sure exactly what is going on with the machine in question,
>> and I don't really have physical access to sort it out.  The kernel
>> messages that I was getting now make a lot more sense.  I'll see if I
>> can change how I detect other nodes shutting down to fix that.
>
> You are welcome to show the kernel messages. After re-reading your first
> mail of this thread I'm still puzzled what's going on. A node goes
> bus-off in case of serious electrical problems on the bus, e.g. improper
> termination, bitrate does not matches, etc. It does *not* go bus off
> just because no other nodes are on the bus (ack slot error).
>
> Wolfgang.
>
>> On Fri, Jun 27, 2014 at 10:34 AM, Oliver Hartkopp
>> <socketcan@hartkopp.net> wrote:
>>> On 27.06.2014 18:28, Wolfgang Grandegger wrote:
>>>> On 06/27/2014 05:45 PM, Jason R1 White wrote:
>>>>> So is it still the recommendation to close the interface to flush the
>>>>> queues?
>>>>
>>>> As I said: the purpose of "restart" is not to do a fast if down->up.
>>>>
>>>>> Is there anything planned for an ip command or IOCTL to do this?
>>>>
>>>> It's on the wish list, let's say. Somebody needs to implement it. It's
>>>> also not straight-forward because there might be more than one socket
>>>> sending out CAN messages. For standard network devices there is no way
>>>> to flush all TX queues, IIRC.
>>>
>>> Probably shutting down the netdevice at BUS_OFF would be an alternative to
>>> restart-ms. When the netdevice is down all sockets are notified by -ENETDOWN.
>>>
>>> We would need some kind of notification when frames got lost anyway. And after
>>> -ENETDOWN the application can recover and set up it's communication again.
>>>
>>> Regards,
>>> Oliver
>>>
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-can" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-can" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>

Here is what I see.

Jun 26 08:22:48 vpc6 kernel: [11535.284175] IPv6:
ADDRCONF(NETDEV_CHANGE): can0: link becomes ready
Jun 26 08:22:49 vpc6 kernel: [11536.262785] peak_pci 0000:04:00.0
can0: error warning interrupt
Jun 26 08:22:49 vpc6 kernel: [11536.265786] peak_pci 0000:04:00.0
can0: error passive interrupt
Jun 26 08:22:49 vpc6 kernel: [11536.266303] peak_pci 0000:04:00.0
can0: error passive interrupt
Jun 26 08:22:49 vpc6 kernel: [11536.270523] peak_pci 0000:04:00.0
can0: error passive interrupt
Jun 26 08:22:49 vpc6 kernel: [11536.271071] peak_pci 0000:04:00.0
can0: error passive interrupt
Jun 26 08:22:49 vpc6 kernel: [11536.271713] peak_pci 0000:04:00.0
can0: error passive interrupt
Jun 26 08:22:49 vpc6 kernel: [11536.272248] peak_pci 0000:04:00.0
can0: error passive interrupt
Jun 26 08:22:49 vpc6 kernel: [11536.279182] peak_pci 0000:04:00.0
can0: error passive interrupt
Jun 26 08:22:49 vpc6 kernel: [11536.281212] peak_pci 0000:04:00.0
can0: error warning interrupt
Jun 26 08:22:49 vpc6 kernel: [11536.281218] peak_pci 0000:04:00.0 can0: bus-off
Jun 26 08:22:50 vpc6 kernel: [11537.281885] peak_pci 0000:04:00.0
can0: restarted
Jun 26 08:22:50 vpc6 kernel: [11537.281948] IPv6:
ADDRCONF(NETDEV_CHANGE): can0: link becomes ready
Jun 26 08:22:50 vpc6 kernel: [11537.283897] peak_pci 0000:04:00.0
can0: error warning interrupt
Jun 26 08:22:51 vpc6 kernel: [11538.255450] peak_pci 0000:04:00.0
can0: error passive interrupt
Jun 26 08:22:51 vpc6 kernel: [11538.260195] peak_pci 0000:04:00.0
can0: error passive interrupt
Jun 26 08:22:51 vpc6 kernel: [11538.260365] peak_pci 0000:04:00.0
can0: error passive interrupt
Jun 26 08:22:51 vpc6 kernel: [11538.261225] peak_pci 0000:04:00.0
can0: error passive interrupt
Jun 26 08:22:51 vpc6 kernel: [11538.267145] peak_pci 0000:04:00.0
can0: error passive interrupt
Jun 26 08:22:51 vpc6 kernel: [11538.267685] peak_pci 0000:04:00.0
can0: error passive interrupt
Jun 26 08:22:51 vpc6 kernel: [11538.267926] peak_pci 0000:04:00.0
can0: error passive interrupt
Jun 26 08:22:51 vpc6 kernel: [11538.269352] peak_pci 0000:04:00.0
can0: error passive interrupt
Jun 26 08:22:51 vpc6 kernel: [11538.269565] peak_pci 0000:04:00.0
can0: error passive interrupt
Jun 26 08:22:51 vpc6 kernel: [11538.270125] peak_pci 0000:04:00.0
can0: error passive interrupt
Jun 26 08:22:51 vpc6 kernel: [11538.270342] peak_pci 0000:04:00.0
can0: error passive interrupt
Jun 26 08:22:51 vpc6 kernel: [11538.271370] peak_pci 0000:04:00.0
can0: error passive interrupt
Jun 26 08:22:51 vpc6 kernel: [11538.271997] peak_pci 0000:04:00.0
can0: error passive interrupt
Jun 26 08:22:51 vpc6 kernel: [11538.272505] peak_pci 0000:04:00.0
can0: error passive interrupt
Jun 26 08:22:51 vpc6 kernel: [11538.272720] peak_pci 0000:04:00.0
can0: error passive interrupt
Jun 26 08:22:51 vpc6 kernel: [11538.273271] peak_pci 0000:04:00.0
can0: error passive interrupt
Jun 26 08:22:51 vpc6 kernel: [11538.273498] peak_pci 0000:04:00.0
can0: error passive interrupt
Jun 26 08:22:51 vpc6 kernel: [11538.288521] peak_pci 0000:04:00.0
can0: error warning interrupt
Jun 26 08:22:51 vpc6 kernel: [11538.288529] peak_pci 0000:04:00.0 can0: bus-off
Jun 26 08:22:52 vpc6 kernel: [11539.287686] peak_pci 0000:04:00.0
can0: restarted

Austin
