From: Austin Schuh <austin@peloton-tech.com>
Subject: Re: Stuck vcan
Date: Tue, 11 Mar 2014 13:37:32 -0700
Message-ID: <CANGgnMbtfaowdGjVRbQ9L8TJBKmbAaNxjApPsc=JDM7e28U8LA@mail.gmail.com>
References: <CANGgnMZLZ+Uhdjpw0QC1ER74FFyot6sjSpcL0Q+HK7ydQTynsg@mail.gmail.com>
	<531EB5A4.1090302@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:52715 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755804AbaCKUhd (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 11 Mar 2014 16:37:33 -0400
Received: by mail-ie0-f172.google.com with SMTP id as1so9569269iec.31
        for <linux-can@vger.kernel.org>; Tue, 11 Mar 2014 13:37:33 -0700 (PDT)
In-Reply-To: <531EB5A4.1090302@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org

On Tue, Mar 11, 2014 at 12:05 AM, Oliver Hartkopp
<socketcan@hartkopp.net> wrote:
> Hi Austin,
>
>
>
> On 11.03.2014 01:22, Austin Schuh wrote:
>
>> $ Linux vpc3 3.10-3-rt-amd64 #1 SMP PREEMPT RT Debian 3.10.11-1
>
> Oh, one of these -rt kernels again %-)
>
>> Mar 10 16:49:12 vpc3 kernel: [356480.638351] Dead loop on virtual device
>> vcan2, fix it urgently!
>
> The vcan driver usually does not set the IFF_ECHO flag:
>>
>> austin[4262] vpc3 ~
>> $ ifconfig vcan2
>> vcan2     Link encap:UNSPEC  HWaddr
>> 00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00
>>           UP RUNNING NOARP  MTU:16  Metric:1
>                             ^^
> Which would be indicated here then.
>
> Therefore the 'shortcut' in af_can.c is used to provide the echo:
>
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/net/can/af_can.c#n283
>
> which increases performance but may lead to funny effects as the sending
> process leads to a reception event which is probably already handled by the
> receiver when the write() of the sender returns.
>
> Two things I would suggest:
>
> 1. Let the vcan really handle the frames by enabling IFF_ECHO
> 2. Add a queue (queue length != 0) to the vcan interface
>
> For 1: Insert the vcan module with the parameter echo=1, e.g.
>
> # rmmod vcan
> # modprobe vcan echo=1
> # ip link add type vcan
> # ip link show vcan0
> 26: vcan0: <NOARP,ECHO> mtu 16 qdisc noop state DOWN mode DEFAULT group default
>     link/can
>
> And see if this already fixes your problem ('ECHO' is enabled here).
>
> For 2: Add a queue length to your vcan with
>
> # ip link set vcan0 txqueuelen 10
> # ip link show vcan0
> 26: vcan0: <NOARP,ECHO> mtu 16 qdisc noop state DOWN mode DEFAULT group default qlen 10
>     link/can
>
> This urges the network subsystem to used the normal packet flow, as a queue
> length of zero is only feasible for software devices like loopback / vcan ...
>
> Please give a feedback if it solves the problem in your -rt kernel.
>
> Best regards,
> Oliver
>

Hi Oliver,

I'm not trying to cause problems ;)

Neither of those helped.

# ifconfig vcan0
vcan0     Link encap:UNSPEC  HWaddr
00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00
          UP RUNNING NOARP  MTU:16  Metric:1
          RX packets:428406 errors:0 dropped:0 overruns:0 frame:0
          TX packets:428406 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:3427248 (3.2 MiB)  TX bytes:3427248 (3.2 MiB)

# ip link show vcan0
17: vcan0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc noqueue state UNKNOWN
mode DEFAULT
    link/can

# ifconfig vcan0
vcan0     Link encap:UNSPEC  HWaddr
00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00
          UP RUNNING NOARP  MTU:16  Metric:1
          RX packets:1400094 errors:0 dropped:0 overruns:0 frame:0
          TX packets:1400094 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:10
          RX bytes:11200752 (10.6 MiB)  TX bytes:11200752 (10.6 MiB)

# ip link show vcan0
17: vcan0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc noqueue state UNKNOWN
mode DEFAULT qlen 10
    link/can

Both times, I get the following.

Mar 11 13:28:58 aschuh-peloton kernel: [96229.460901] Dead loop on
virtual device vcan0, fix it urgently!
Mar 11 13:28:59 aschuh-peloton kernel: [96230.313875] Dead loop on
virtual device vcan0, fix it urgently!
Mar 11 13:28:59 aschuh-peloton kernel: [96230.319494] Dead loop on
virtual device vcan0, fix it urgently!
Mar 11 13:29:00 aschuh-peloton kernel: [96231.072617] Dead loop on
virtual device vcan0, fix it urgently!

Luckily, it is easy to reproduce.  I have some trivial code which
sends out 10,000 msgs/sec on the vcan.  I run 3+ copies of the code on
a dual core machine with hyperthreads enabled.  More parallel sends
should cause it to occur more frequently.

Austin
