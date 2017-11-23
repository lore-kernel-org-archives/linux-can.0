From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 0/7] R-Car D3 (r8a77995) CAN support
Date: Thu, 23 Nov 2017 09:43:47 +0000
Message-ID: <20171123094336.h376j4iuewaqys4i@verge.net.au>
References: <1510915289-15059-1-git-send-email-ulrich.hecht+renesas@gmail.com>
 <20171122181045.5pstmikwp43idts5@verge.net.au>
 <CAO3366xk+Spa=z6bFW9TfqPk_8wUEd5scMK35JbXwpxZ2z7L2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:45738 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751967AbdKWJoQ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 23 Nov 2017 04:44:16 -0500
Content-Disposition: inline
In-Reply-To: <CAO3366xk+Spa=z6bFW9TfqPk_8wUEd5scMK35JbXwpxZ2z7L2w@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>, linux-can@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Magnus Damm <magnus.damm@gmail.com>, Chris Paterson <chris.paterson2@renesas.com>, Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>

On Thu, Nov 23, 2017 at 08:43:18AM +0100, Ulrich Hecht wrote:
> On Wed, Nov 22, 2017 at 7:10 PM, Simon Horman <horms@verge.net.au> wrote:
> > On Fri, Nov 17, 2017 at 11:41:22AM +0100, Ulrich Hecht wrote:
> >> Hi!
> >>
> >> Here's CAN and CAN FD support for the R-Car D3. This is a by-the-datasheet
> >> implementation, with the datasheet missing some bits, namely the pin map.
> >> I filled in the gaps with frog DNA^W^W^Wby deducing the information from
> >> pin numbers already in the PFC driver, so careful scrutiny is advised.
> >>
> >> CU
> >> Uli
> >>
> >>
> >> Ulrich Hecht (7):
> >>   pinctrl: sh-pfc: r8a77995: Add CAN support
> >>   pinctrl: sh-pfc: r8a77995: Add CAN FD support
> >>   arm64: dts: r8a77995: Add CAN external clock support
> >>   arm64: dts: r8a77995: Add CAN support
> >>   arm64: dts: r8a77995: Add CAN FD support
> >>   can: rcar_can: document r8a77995 (R-Car D3) compatibility strings
> >>   can: rcar_canfd: document r8a77995 (R-Car D3) compatibility strings
> >
> > Hi Ulrich,
> >
> > is it safe, from a regression point of view, to apply the dts patches
> > to a tree that does not have the other patches present?
> 
> I believe it is.

Thanks. I have applied them for v4.16.
