From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: linux-can ISOTP module
Date: Wed, 04 Jun 2014 20:40:54 +0200
Message-ID: <538F6836.3060508@hartkopp.net>
References: <loom.20140604T144601-350@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:62911 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933AbaFDSk6 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 4 Jun 2014 14:40:58 -0400
In-Reply-To: <loom.20140604T144601-350@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: laurent vaudoit <laurent.vaudoit@gmail.com>
Cc: linux-can@vger.kernel.org

Hi Laurent,

On 04.06.2014 14:55, laurent vaudoit wrote:

> i'm using isotp module for some work purpose,
> on a imx25 board, with kernel 3.10.
> 
> I have integrated the module isotp and the correct header file in my
> kernel.
> 
> I'm able to use isotpsend adn isotprecv functions but i have some questions:
> 
> Comming from automotiv diagnostic, we are used to configure a lots of 
> parameters in our baremetal Iso15765 protocol firmware (stmin, 
> bs,n_cs,n_bs...)
> I have not seen anything to parameter timings such as n_cs, n_bs.
> Is their something i missed?

Definitely :-)

See the help text from isotprecv:

---

Usage: isotprecv [options] <CAN interface>
Options: -s <can_id>  (source can_id. Use 8 digits for extended IDs)
         -d <can_id>  (destination can_id. Use 8 digits for extended IDs)
         -x <addr>    (extended addressing mode.)
         -p <byte>    (set and enable padding byte)
         -P <mode>    (check padding in SF/CF. (l)ength (c)ontent (a)ll)
         -b <bs>      (blocksize. 0 = off)
         -m <val>     (STmin in ms/ns. See spec.)
         -f <time ns> (force rx stmin value in nanosecs)
         -w <num>     (max. wait frame transmissions.)
         -l           (loop: do not exit after pdu receiption.)

CAN IDs and addresses are given and expected in hexadecimal values.
The pdu data is written on STDOUT in space separated ASCII hex values.

---

Please check out the isotprecv.c source code to see how these parameters are
to be set with setsockopt() syscall.

See isotp.h for all socketoptions and structures:
https://gitorious.org/linux-can/can-modules/source/f306f8ef6154d5625f261374917ec6226910fbbb:include/socketcan/can/isotp.h

isotprecv.c and isotpsend.c make use of all possible options which can be
triggerd by commandline options.

> 
> For extended adressing method, it seems that both rx and tx frame must have 
> the same first byte in can frame (the one set by ext_address field of the 
> structure). This is correct for mixed addressing method (see Iso15765-2), 
> but for extended adressing method, we should be able to specify different 
> Target and source adress. I have not seen anything like this.

One socket represents one virtual 1:1 connection (defined by two CAN
identifiers and optional with one address extension) on the CAN bus.

If you want to receive from different sources just create different sockets
(and e.g. use select() to listen to many open socket file descriptors).

The protocol engine has always to answer with the correct address information.

> 
> Last point, if i want to send a 255 bytes frame, with bs=0 and stmin=0 
> (requested by the receiver), transfer start well SN 0x01 to SN 0x0B) but 
> after i have a frame with SN 0x03 instead of SN = 0x0C and everything stop.
> 
> Does anyone encountered this kind of problem?
> 

No.

Using the isotpsend from my canfd4isotp-can-utils git repository (which
supports the -D <num> option to create a PDU with the given length:

$ ./isotpsend vcan0 -s 123 -d 321 -D 255

On another terminal it looks like this then:

$ isotprecv vcan0 -s 321 -d 123
01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F 10 11 12 13 14 15 16 17 18 19 1A
1B 1C 1D 1E 1F 20 21 22 23 24 25 26 27 28 29 2A 2B 2C 2D 2E 2F 30 31 32 33 34
35 36 37 38 39 3A 3B 3C 3D 3E 3F 40 41 42 43 44 45 46 47 48 49 4A 4B 4C 4D 4E
4F 50 51 52 53 54 55 56 57 58 59 5A 5B 5C 5D 5E 5F 60 61 62 63 64 65 66 67 68
69 6A 6B 6C 6D 6E 6F 70 71 72 73 74 75 76 77 78 79 7A 7B 7C 7D 7E 7F 80 81 82
83 84 85 86 87 88 89 8A 8B 8C 8D 8E 8F 90 91 92 93 94 95 96 97 98 99 9A 9B 9C
9D 9E 9F A0 A1 A2 A3 A4 A5 A6 A7 A8 A9 AA AB AC AD AE AF B0 B1 B2 B3 B4 B5 B6
B7 B8 B9 BA BB BC BD BE BF C0 C1 C2 C3 C4 C5 C6 C7 C8 C9 CA CB CC CD CE CF D0
D1 D2 D3 D4 D5 D6 D7 D8 D9 DA DB DC DD DE DF E0 E1 E2 E3 E4 E5 E6 E7 E8 E9 EA
EB EC ED EE EF F0 F1 F2 F3 F4 F5 F6 F7 F8 F9 FA FB FC FD FE FF

with candump:

$ candump vcan0
  vcan0  123   [8]  10 FF 01 02 03 04 05 06
  vcan0  321   [3]  30 00 00
  vcan0  123   [8]  21 07 08 09 0A 0B 0C 0D
  vcan0  123   [8]  22 0E 0F 10 11 12 13 14
  vcan0  123   [8]  23 15 16 17 18 19 1A 1B
  vcan0  123   [8]  24 1C 1D 1E 1F 20 21 22
  vcan0  123   [8]  25 23 24 25 26 27 28 29
  vcan0  123   [8]  26 2A 2B 2C 2D 2E 2F 30
  vcan0  123   [8]  27 31 32 33 34 35 36 37
  vcan0  123   [8]  28 38 39 3A 3B 3C 3D 3E
  vcan0  123   [8]  29 3F 40 41 42 43 44 45
  vcan0  123   [8]  2A 46 47 48 49 4A 4B 4C
  vcan0  123   [8]  2B 4D 4E 4F 50 51 52 53
  vcan0  123   [8]  2C 54 55 56 57 58 59 5A
  vcan0  123   [8]  2D 5B 5C 5D 5E 5F 60 61
  vcan0  123   [8]  2E 62 63 64 65 66 67 68
  vcan0  123   [8]  2F 69 6A 6B 6C 6D 6E 6F
  vcan0  123   [8]  20 70 71 72 73 74 75 76
  vcan0  123   [8]  21 77 78 79 7A 7B 7C 7D
  vcan0  123   [8]  22 7E 7F 80 81 82 83 84
  vcan0  123   [8]  23 85 86 87 88 89 8A 8B
  vcan0  123   [8]  24 8C 8D 8E 8F 90 91 92
  vcan0  123   [8]  25 93 94 95 96 97 98 99
  vcan0  123   [8]  26 9A 9B 9C 9D 9E 9F A0
  vcan0  123   [8]  27 A1 A2 A3 A4 A5 A6 A7
  vcan0  123   [8]  28 A8 A9 AA AB AC AD AE
  vcan0  123   [8]  29 AF B0 B1 B2 B3 B4 B5
  vcan0  123   [8]  2A B6 B7 B8 B9 BA BB BC
  vcan0  123   [8]  2B BD BE BF C0 C1 C2 C3
  vcan0  123   [8]  2C C4 C5 C6 C7 C8 C9 CA
  vcan0  123   [8]  2D CB CC CD CE CF D0 D1
  vcan0  123   [8]  2E D2 D3 D4 D5 D6 D7 D8
  vcan0  123   [8]  2F D9 DA DB DC DD DE DF
  vcan0  123   [8]  20 E0 E1 E2 E3 E4 E5 E6
  vcan0  123   [8]  21 E7 E8 E9 EA EB EC ED
  vcan0  123   [8]  22 EE EF F0 F1 F2 F3 F4
  vcan0  123   [8]  23 F5 F6 F7 F8 F9 FA FB
  vcan0  123   [5]  24 FC FD FE FF

with isotpdump:

$ isotpdump -s 123 -d 321 vcan0
 vcan0  123  [8]  [FF] ln: 255  data: 01 02 03 04 05 06
 vcan0  321  [3]  [FC] FC: 0 = CTS # BS: 0 = off # STmin: 0x00 = 0 ms
 vcan0  123  [8]  [CF] sn: 1    data: 07 08 09 0A 0B 0C 0D
 vcan0  123  [8]  [CF] sn: 2    data: 0E 0F 10 11 12 13 14
 vcan0  123  [8]  [CF] sn: 3    data: 15 16 17 18 19 1A 1B
 vcan0  123  [8]  [CF] sn: 4    data: 1C 1D 1E 1F 20 21 22
 vcan0  123  [8]  [CF] sn: 5    data: 23 24 25 26 27 28 29
 vcan0  123  [8]  [CF] sn: 6    data: 2A 2B 2C 2D 2E 2F 30
 vcan0  123  [8]  [CF] sn: 7    data: 31 32 33 34 35 36 37
 vcan0  123  [8]  [CF] sn: 8    data: 38 39 3A 3B 3C 3D 3E
 vcan0  123  [8]  [CF] sn: 9    data: 3F 40 41 42 43 44 45
 vcan0  123  [8]  [CF] sn: A    data: 46 47 48 49 4A 4B 4C
 vcan0  123  [8]  [CF] sn: B    data: 4D 4E 4F 50 51 52 53
 vcan0  123  [8]  [CF] sn: C    data: 54 55 56 57 58 59 5A
 vcan0  123  [8]  [CF] sn: D    data: 5B 5C 5D 5E 5F 60 61
 vcan0  123  [8]  [CF] sn: E    data: 62 63 64 65 66 67 68
 vcan0  123  [8]  [CF] sn: F    data: 69 6A 6B 6C 6D 6E 6F
 vcan0  123  [8]  [CF] sn: 0    data: 70 71 72 73 74 75 76
 vcan0  123  [8]  [CF] sn: 1    data: 77 78 79 7A 7B 7C 7D
 vcan0  123  [8]  [CF] sn: 2    data: 7E 7F 80 81 82 83 84
 vcan0  123  [8]  [CF] sn: 3    data: 85 86 87 88 89 8A 8B
 vcan0  123  [8]  [CF] sn: 4    data: 8C 8D 8E 8F 90 91 92
 vcan0  123  [8]  [CF] sn: 5    data: 93 94 95 96 97 98 99
 vcan0  123  [8]  [CF] sn: 6    data: 9A 9B 9C 9D 9E 9F A0
 vcan0  123  [8]  [CF] sn: 7    data: A1 A2 A3 A4 A5 A6 A7
 vcan0  123  [8]  [CF] sn: 8    data: A8 A9 AA AB AC AD AE
 vcan0  123  [8]  [CF] sn: 9    data: AF B0 B1 B2 B3 B4 B5
 vcan0  123  [8]  [CF] sn: A    data: B6 B7 B8 B9 BA BB BC
 vcan0  123  [8]  [CF] sn: B    data: BD BE BF C0 C1 C2 C3
 vcan0  123  [8]  [CF] sn: C    data: C4 C5 C6 C7 C8 C9 CA
 vcan0  123  [8]  [CF] sn: D    data: CB CC CD CE CF D0 D1
 vcan0  123  [8]  [CF] sn: E    data: D2 D3 D4 D5 D6 D7 D8
 vcan0  123  [8]  [CF] sn: F    data: D9 DA DB DC DD DE DF
 vcan0  123  [8]  [CF] sn: 0    data: E0 E1 E2 E3 E4 E5 E6
 vcan0  123  [8]  [CF] sn: 1    data: E7 E8 E9 EA EB EC ED
 vcan0  123  [8]  [CF] sn: 2    data: EE EF F0 F1 F2 F3 F4
 vcan0  123  [8]  [CF] sn: 3    data: F5 F6 F7 F8 F9 FA FB
 vcan0  123  [5]  [CF] sn: 4    data: FC FD FE FF

Please check out the README.isotp:

https://gitorious.org/linux-can/can-modules/source/f306f8ef6154d5625f261374917ec6226910fbbb:README.isotp

Did you probably run your test on a real CAN interface but did not increase
the tx queue length of the CAN netdevice accordingly??

> I will search for this problem as it is a big problem if we want to make 
> some download through isotp.

I flashed several instrument clusters and climate control ECUs with this
implementation :-)

Regards,
Oliver

