From: Andri Yngvason <andri.yngvason@marel.com>
Subject: Re: canfdtest missing tx frame
Date: Wed, 2 Nov 2016 16:47:19 +0000
Message-ID: <147810523969.9191.3347569271701639587@maxwell>
References: <1579A5A5423CC14B827884B535F8E9513493B8CE@SSCOXCHG2.spray.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-db5eur01on0076.outbound.protection.outlook.com ([104.47.2.76]:22952
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756303AbcKBRIb (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 2 Nov 2016 13:08:31 -0400
In-Reply-To: <1579A5A5423CC14B827884B535F8E9513493B8CE@SSCOXCHG2.spray.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Grim, Dennis" <Dennis.Grim@teejet.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Quoting Grim, Dennis (2016-11-02 15:12:01)
> I'm running canfdtest between two ports of a PEAK PCAN-PCI Express card. =
 The card appears to use the SJA1000.  The bus is terminated.
> =

> The ports are configured using:
> ip link set can0 up type can bitrate 250000
> ip link set can1 up type can bitrate 250000
> =

> The test is run using:
> canfdtest can1
> canfdtest -g -v -l 1000 can0
> =

> canfdtest aborts at random numbers of test messages sent and received.  T=
he number might be less than 10 or might be several hundred.  It never reac=
hes 1000.
> =

[...]

Hi Dennis,

See this thread: http://marc.info/?l=3Dlinux-can&m=3D144785931426968&w=3D2

Work-around here: http://marc.info/?l=3Dlinux-can&m=3D144908079021623&w=3D2

PEAK have acknowledged an issue with the firmware, and I assume that they h=
ave
fixed the issue in the firmware, and they did post a patch for working arou=
nd
the issue with older firmware, but no one has followed through on it.

Regards,
Andri
