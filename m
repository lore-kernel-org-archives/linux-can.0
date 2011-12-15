From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: using can-j1939
Date: Thu, 15 Dec 2011 15:00:12 +0100
Message-ID: <20111215140012.GA10848@e-circ.dyndns.org>
References: <20111213155110.GA314@e-circ.dyndns.org>
 <loom.20111214T140958-737@post.gmane.org>
 <20111214154351.GB6112@e-circ.dyndns.org>
 <loom.20111214T190347-790@post.gmane.org>
 <20111214204237.GC306@e-circ.dyndns.org>
 <loom.20111215T085023-710@post.gmane.org>
 <20111215092018.GB321@e-circ.dyndns.org>
 <loom.20111215T114301-18@post.gmane.org>
 <20111215120434.GD321@e-circ.dyndns.org>
 <loom.20111215T142642-767@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gate.eia.be ([194.78.71.18]:28785 "EHLO mail.eia.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751349Ab1LOOAZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 15 Dec 2011 09:00:25 -0500
Content-Disposition: inline
In-Reply-To: <loom.20111215T142642-767@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang <wutz@unterderbruecke.de>
Cc: linux-can@vger.kernel.org

On Thu, Dec 15, 2011 at 01:43:30PM +0000, Wolfgang wrote:
> I copied all things as you told me, I think/hope the hardest part is over now.
> Thank you!!
> 
> 
> What do I have to do afterwards I did
> 
> $ echo can0 /proc/net/can-j1939/net
$ echo can0 > /proc/net/can-j1939/net

> 
> because if I do '$ifconfig can0 up' it responses with 
> 
> mpc52xx_can 80001300.mscan: bit-timing not yet defined
> ifconfig: SIOCSIFFLAGS: Invalid argument

try:

$ ip link set can0 up type can bitrate 250000
> 
> 
> (Just for information this time different answer:
> $ ip link set can0 j1939 on
> RTNETLINK answers: Invalid argument )
> 

now, you can:

$ jspy -P
to see all j1939 packets. Transport Protocol sessions are assembled into big packets.

> Is there any documentation
There isn't much documenation yet of jspy & jsr, but they are basic tools.

$ jspy -?
produces:
jspy: An SAE J1939 spy utility
Usage: jspy [OPTION...] [[IFACE:][NAME|SA][,PGN]]

  -v, --verbose         Increase verbosity
  -P, --promisc         Run in promiscuous mode
                        (= receive traffic not for this ECU)
  -b, --block=SIZE      Use a receive buffer of SIZE (default 1024)
  -t, --time[=a|d|z|A]  Show time: (a)bsolute, (d)elta, (z)ero, (A)bsolute w date

$ jsr -?
produces:
jsr: An SAE J1939 send/recv utility
Usage: jsr [OPTION...] SOURCE [DEST]

  -v, --verbose         Increase verbosity
  -p, --priority=VAL    J1939 priority (0..7, default 6)
  -S, --serialize       Strictly serialize outgoing packets
  -s, --size            Packet size, default autodetected

  SOURCE        [IFACE:][NAME|SA][,PGN]
  DEST                  [NAME|SA]

jsr allows you to put stdin into transmitted j1939 packets, and received j1939 packets
onto stdout.

jacd is used for dynamic address claiming. I believe it's a bit early to start with.

$ ip
can now be used to:
* add SA 0x80 to can0

$ ip addr add j1939 0x80 dev can0

from that point, 0x80 can be used to send packets with.

and likewise
$ ip addr del j1939 0x80 dev can0

$ ip addr
may show things like:

4: can0: <NOARP,ECHO> mtu 16 qdisc noop state DOWN qlen 10
    link/can 
    can-j1939 0x80 scope link 

> or is it possible to use cangw with API?
cangw (like can-j1939) is not present in your 2.6.31 kernel.
Since you managed importing can-j1939, importing cangw will succeed definitely.
cangw requires less modification in userspace tools ...

Before proceeding however, what exactly is the application?
Will you bridge j1939 packets unmodified?
Are transport sessions involved?
Is information repacked into different packets?

...
Kurt
