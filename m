From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: sja1000 interrupt problem
Date: Thu, 07 Nov 2013 09:15:00 +0100
Message-ID: <84ba410d04a85a783d1c1994f98d1f31@grandegger.com>
References: <CANGgnMZTugYEZDi5wrmFVP5K=ZMhKsgZJ5VQLP6Y0nxbCsDZ7w@mail.gmail.com>
 <3a4a0c6ac898fbe27a8fe95cb147634c@grandegger.com>
 <99984642-b542-4078-a5ba-3dfb66188ce5@email.android.com>
 <CANGgnMb130WSkOkreRyRg9cXhMn=MXhGmhMqXKMOTkiTMD4vqQ@mail.gmail.com>
 <5254608B.4080208@grandegger.com>
 <CANGgnMYN3epBb_b=AywUQbN_LQLu6C6ebCfE0xifzoS0Yw1y1g@mail.gmail.com>
 <be0d6725fff5298d3fb8417e4800348b@grandegger.com>
 <CANGgnMZpPGctUWGcg7Lp-QFPc7d6A5GeL9KQYnpeYMR8WukgdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from uranus.manitu.net ([217.11.48.8]:36741 "EHLO uranus.manitu.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751581Ab3KGIPC (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 7 Nov 2013 03:15:02 -0500
In-Reply-To: <CANGgnMZpPGctUWGcg7Lp-QFPc7d6A5GeL9KQYnpeYMR8WukgdA@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Austin Schuh <austin@peloton-tech.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

Hi Austin,



On Wed, 6 Nov 2013 16:33:26 -0800, Austin Schuh <austin@peloton-tech.com>

wrote:

> Hi Wolfgang,

> 

> Thanks for the help.  It took me longer than I would like to admit to

> get a nice clean trace, and to fight some fires so I could get back to

> this.

> 

> I disabled tracing where you suggested, and rebuilt the kernel.

> 

> 283   if (unlikely(action_ret == IRQ_NONE)) {

> 284     /*

> 285      * If we are seeing only the odd spurious IRQ caused by

> 286      * bus asynchronicity then don't eventually trigger an error,

> 287      * otherwise the counter becomes a doomsday timer for otherwise

> 288      * working systems

> 289      */

> 290     if (irq == 18) {

> 291       pr_info("Unhandled IRQ 18... stop tracing...\n");

> 292       tracing_off();

> 293     }

> --- snip ---

> 

> I'm getting that there is an unhandled IRQ every time I send/receive a

> packet.  My test setup is that I send from one of the two CAN ports to

> the other using the CLI tools.

> 

> echo 1 > tracing_on; cansend can0 500#1E.10.10.00.00.00.00.01;

> 

> The dump is attached.



I do not see any sja1000_rx() calls. Either they never happen or more

likely the trace is not long enough. Could you try with a larger buffer

using "echo 20000 > buffer_size_kb"? I also do not see some pr_info()

related functions at the end of the trace. Are you sure is has stopped

(cat tracing_on or message in dmesg)?



Also please do an "echo 0 > trace" to clear the trace content.



Wolfgang.



> On Tue, Oct 8, 2013 at 11:47 PM, Wolfgang Grandegger <wg@grandegger.com>

> wrote:

>> Hi Austin,

>>

>> I have some trouble with my WEB mail interface resulting in two

>> incomplete

>> messages sent out...

>>

>>

>> On Tue, 8 Oct 2013 13:47:06 -0700, Austin Schuh

<austin@peloton-tech.com>

>> wrote:

>>> Hi Wolfgang,

>>>

>>> Thanks for taking the time to help!

>>>

>>> Both CAN channels are active and at least one of them has external

>>> traffic on the bus when the problem occurs.

>>>

>>> I have installed the PEAK card in an "IntensePC" (

>>> http://www.fit-pc.com/web/products/intense-pc/ ).  It is in the only

>>> full sized miniPCIe slot in the PC.

>>>

>>> I'll start some tests to determine the mean failure time so I can try

>>> a non-rt kernel and give you a definitive answer on whether or not

>>> that fixes it.  That could take me a day or two given how long it

>>> takes to reproduce.

>>

>> Not sure if it's worth the effort... at least for the moment.

>>

>>> I built the kernel once already, and am comfortable patching it.  I'm

>>> currently running a Debian Sid kernel (3.10).  I saw the same problem

>>> with the Debian 3.2 kernel where I backported the sja1000 driver.

>>

>> OK, I think the SJA1000 gets stuck for some reason. My idea is to do an

>> ftrace freeze when IRQ 18 is not handled. Could you please add:

>>

>>     if (irq == 18) {

>>         "pr_info("Unhandled IRQ 18... stop tracing...\n");

>>          tracing_off();

>>     }

>>

>> here:

>>

>>     http://lxr.free-electrons.com/source/kernel/irq/spurious.c#L291

>>

>> ... actually when the first unhandled IRQ 18 shows up. You can

>> activate function tracing as shown below:

>>

>>   # cd /sys/kernel/debug/tracing/

>>   # echo function > current_tracer

>>

>> When the tracing is stop via unhandled IRQ 18 just save the trace:

>>

>>    # cp trace /tmp/trace.log

>>

>> You may need to increase the tracing buffer:

>>

>>    # echo 20000 > buffer_total_size_kb

>>

>> This will introduce some overhead. Let's hope that the problem does

>> still show up.

>>

>>> $ ip -d -s link

>> ...

>>  4: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state

>>> UNKNOWN mode DEFAULT qlen 10

>>>     link/can

>>>     can <TRIPLE-SAMPLING> state ERROR-ACTIVE (berr-counter tx 0 rx 0)

>>

>> BTW. why are you using TRIPLE-SAMPLING. IIRC, it's mainly useful for

low

>> CAN

>> bitrates. At 800 kBits/s it's usually not set.

>>

>> Wolfgang.

>>


