From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: ti hecc rx frames out of order
Date: Sun, 4 Dec 2016 14:07:16 +0100
Message-ID: <08de827f-0d1b-4523-0ed9-f0979345de87@hartkopp.net>
References: <1579A5A5423CC14B827884B535F8E951349421F6@SSCOXCHG2.spray.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:23245 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750778AbcLDNH1 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 4 Dec 2016 08:07:27 -0500
In-Reply-To: <1579A5A5423CC14B827884B535F8E951349421F6@SSCOXCHG2.spray.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Grim, Dennis" <Dennis.Grim@teejet.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Dennis,

On 12/02/2016 08:43 PM, Grim, Dennis wrote:
> When running canfdtest on a TI AM3517 HECC, frames randomly appear out of order.
>
> "can-utils" is current (cloned this week from github)
>
> Linux kernel is 3.19.0.

(..)

> From Peak PCAN-View:

> 99904)    594366.8  Rx         0077  8  F3 F4 F5 F6 F7 F8 F9 FA
> 99905)    594367.3  Rx         0078  8  F2 F3 F4 F5 F6 F7 F8 F9
> 99906)    594367.8  Rx         0078  8  F3 F4 F5 F6 F7 F8 F9 FA
> 99907)    594368.3  Rx         0077  8  F4 F5 F6 F7 F8 F9 FA FB
> 99908)    594368.7  Rx         0078  8  F1 F2 F3 F4 F5 F6 F7 F8      NOTE: this line is out of order
> 99909)    594369.2  Rx         0077  8  F5 F6 F7 F8 F9 FA FB FC
> 99910)    594369.7  Rx         0078  8  F4 F5 F6 F7 F8 F9 FA FB
> 99911)    594370.2  Rx         0077  8  F6 F7 F8 F9 FA FB FC FD

Please correct me if I'm wrong, but when you can see this out-of-order 
issue on a different host with a different tool:

Doesn't this lead to the question of a TX out-of-order instead of a RX 
out-of-order??

Regards,
Oliver


