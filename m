From: Austin Schuh <austin@peloton-tech.com>
Subject: Re: j1939
Date: Tue, 4 Oct 2016 09:12:58 -0700
Message-ID: <CANGgnMZksGTWAuFEePVN=j3wL2ir4agwxk7Yy0KRTZ9fSGBjrg@mail.gmail.com>
References: <a6ad3606-b295-dc72-c557-098c45769cb9@pengutronix.de>
 <018c2e89-87c0-c1cc-686e-d5d715651ab3@hartkopp.net> <9a40e851-4bc8-f57c-ffc5-478f3ea93acb@pengutronix.de>
 <1be622f4-1376-189b-9180-487aef3dc636@hartkopp.net> <CANGgnMaxNRBDG9WWAanHEem-wDJ1ujxYdqgko7nAx3iJNcPUGA@mail.gmail.com>
 <20160920091525.2ff22d58@erd980> <20161004073703.GB13813@airbook.vandijck-laurijssen.be>
 <20161004145202.6c5238d9@erd980> <20161004135701.GA25008@airbook.vandijck-laurijssen.be>
 <20161004164725.08802a61@erd980>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-yw0-f172.google.com ([209.85.161.172]:34835 "EHLO
        mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752590AbcJDQNU (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 4 Oct 2016 12:13:20 -0400
Received: by mail-yw0-f172.google.com with SMTP id t193so55775512ywc.2
        for <linux-can@vger.kernel.org>; Tue, 04 Oct 2016 09:13:19 -0700 (PDT)
In-Reply-To: <20161004164725.08802a61@erd980>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: David Jander <david@protonic.nl>, Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can <linux-can@vger.kernel.org>

On Tue, Oct 4, 2016 at 7:47 AM David Jander <david@protonic.nl> wrote:
>
> I have yet to check, but I fear that in ISOBus conformance tests on some
> places at least this is tested for. I'd say that if the standard says "pa=
d and
> fill with 0xff", any ECU should do this and not doing it should be regard=
ed as
> a bug...
> I know that PGN 0xEA00 is an exception, and proprietary messages should b=
e
> permitted any length IMHO, so padding every frame (even coming from user-=
space)
> seems unnecessary and unacceptable to me, as it clearly violates the stan=
dard.
> Turning off padding for TP-messages might be a nice-to-have feature, but =
it
> would not be standards-compliant anymore AFAICS.
>
> I guess I don't violate anyone's copyright if I cite a small fragment fro=
m
> ISO-11783-3 here:
>
> In "Transport Protocol =E2=80=94 Data Transfer messages (TP.DT)":
>   [...]
>   "The last packet of a multi-packet parameter group can require less tha=
n
>   8B. The extra bytes shall be filled with 0xFF"
>
> If someone can confirm this is the same language as in J1939, I'd say we =
don't
> really need to support non-padded (E)TP-packets. Please note that I am on=
ly
> referring to (E)TP-packets here!


From SAE-J1939-21

"Data ranges for parameters used by this Group Function:
Sequence Number:
1 to 255 (1 byte)
Byte:
1
Sequence Number
2-8
Packetized Data (7 bytes). Note the last packet of a multipacket
Parameter Group may
require less than 8 data bytes. The extra bytes should be filled with FF 16=
 ."

J1939-21 matches what is in ISO-11783-3

J1939-21 section 5.2.7.1 says that messages with less than 8 bytes of
data are legal.  The recommendation is to pad messages out to 8 bytes
for compatibility and future proofing reasons, but it is not required.

Austin
