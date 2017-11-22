From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 0/7] R-Car D3 (r8a77995) CAN support
Date: Wed, 22 Nov 2017 19:10:45 +0100
Message-ID: <20171122181045.5pstmikwp43idts5@verge.net.au>
References: <1510915289-15059-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:34872 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751796AbdKVSLP (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 22 Nov 2017 13:11:15 -0500
Content-Disposition: inline
In-Reply-To: <1510915289-15059-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-can@vger.kernel.org, devicetree@vger.kernel.org, wsa@the-dreams.de, geert@linux-m68k.org, magnus.damm@gmail.com, chris.paterson2@renesas.com, ramesh.shanmugasundaram@bp.renesas.com

On Fri, Nov 17, 2017 at 11:41:22AM +0100, Ulrich Hecht wrote:
> Hi!
> 
> Here's CAN and CAN FD support for the R-Car D3. This is a by-the-datasheet
> implementation, with the datasheet missing some bits, namely the pin map.
> I filled in the gaps with frog DNA^W^W^Wby deducing the information from
> pin numbers already in the PFC driver, so careful scrutiny is advised.
> 
> CU
> Uli
> 
> 
> Ulrich Hecht (7):
>   pinctrl: sh-pfc: r8a77995: Add CAN support
>   pinctrl: sh-pfc: r8a77995: Add CAN FD support
>   arm64: dts: r8a77995: Add CAN external clock support
>   arm64: dts: r8a77995: Add CAN support
>   arm64: dts: r8a77995: Add CAN FD support
>   can: rcar_can: document r8a77995 (R-Car D3) compatibility strings
>   can: rcar_canfd: document r8a77995 (R-Car D3) compatibility strings

Hi Ulrich,

is it safe, from a regression point of view, to apply the dts patches
to a tree that does not have the other patches present?
