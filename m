From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: sja1000 interrupt problem
Date: Wed, 09 Oct 2013 08:47:56 +0200
Message-ID: <be0d6725fff5298d3fb8417e4800348b@grandegger.com>
References: <CANGgnMZTugYEZDi5wrmFVP5K=ZMhKsgZJ5VQLP6Y0nxbCsDZ7w@mail.gmail.com>
 <3a4a0c6ac898fbe27a8fe95cb147634c@grandegger.com>
 <99984642-b542-4078-a5ba-3dfb66188ce5@email.android.com>
 <CANGgnMb130WSkOkreRyRg9cXhMn=MXhGmhMqXKMOTkiTMD4vqQ@mail.gmail.com>
 <5254608B.4080208@grandegger.com>
 <CANGgnMYN3epBb_b=AywUQbN_LQLu6C6ebCfE0xifzoS0Yw1y1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from pluto.manitu.net ([217.11.48.9]:39381 "EHLO pluto.manitu.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751823Ab3JIGr6 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 9 Oct 2013 02:47:58 -0400
In-Reply-To: <CANGgnMYN3epBb_b=AywUQbN_LQLu6C6ebCfE0xifzoS0Yw1y1g@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Austin Schuh <austin@peloton-tech.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

Hi Austin,



I have some trouble with my WEB mail interface resulting in two incomplete

messages sent out...





On Tue, 8 Oct 2013 13:47:06 -0700, Austin Schuh <austin@peloton-tech.com>

wrote:

> Hi Wolfgang,

> 

> Thanks for taking the time to help!

> 

> Both CAN channels are active and at least one of them has external

> traffic on the bus when the problem occurs.

> 

> I have installed the PEAK card in an "IntensePC" (

> http://www.fit-pc.com/web/products/intense-pc/ ).  It is in the only

> full sized miniPCIe slot in the PC.

> 

> I'll start some tests to determine the mean failure time so I can try

> a non-rt kernel and give you a definitive answer on whether or not

> that fixes it.  That could take me a day or two given how long it

> takes to reproduce.



Not sure if it's worth the effort... at least for the moment.



> I built the kernel once already, and am comfortable patching it.  I'm

> currently running a Debian Sid kernel (3.10).  I saw the same problem

> with the Debian 3.2 kernel where I backported the sja1000 driver.



OK, I think the SJA1000 gets stuck for some reason. My idea is to do an

ftrace freeze when IRQ 18 is not handled. Could you please add:



    if (irq == 18) {

        "pr_info("Unhandled IRQ 18... stop tracing...\n");

         tracing_off();

    }



here:



    http://lxr.free-electrons.com/source/kernel/irq/spurious.c#L291



... actually when the first unhandled IRQ 18 shows up. You can

activate function tracing as shown below:



  # cd /sys/kernel/debug/tracing/

  # echo function > current_tracer



When the tracing is stop via unhandled IRQ 18 just save the trace:



   # cp trace /tmp/trace.log



You may need to increase the tracing buffer:



   # echo 20000 > buffer_total_size_kb



This will introduce some overhead. Let's hope that the problem does

still show up.



> $ ip -d -s link

...

 4: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state

> UNKNOWN mode DEFAULT qlen 10

>     link/can

>     can <TRIPLE-SAMPLING> state ERROR-ACTIVE (berr-counter tx 0 rx 0)



BTW. why are you using TRIPLE-SAMPLING. IIRC, it's mainly useful for low

CAN

bitrates. At 800 kBits/s it's usually not set.



Wolfgang.


