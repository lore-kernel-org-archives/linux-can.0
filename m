From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: A20 CAN device tree overlay
Date: Mon, 20 Mar 2017 09:40:12 +0100
Message-ID: <20170320084012.vim3c2r5pbmmswfu@lukather>
References: <bb45d79c-6975-c1bd-7c9c-98e6af4ef10d@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:42467 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753186AbdCTJVe (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 20 Mar 2017 05:21:34 -0400
Content-Disposition: inline
In-Reply-To: <bb45d79c-6975-c1bd-7c9c-98e6af4ef10d@posteo.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Patrick Menschel <menschel.p@posteo.de>
Cc: linux-can <linux-can@vger.kernel.org>

Hi,

On Fri, Mar 17, 2017 at 05:57:05PM +0100, Patrick Menschel wrote:
> Hello Maxime,
> 
> I'd like to send a patch for a dt overlay to enable CAN on the A20 SoC,
> e.g. Banana Pi.
> However I don't know the correct location for a sunxi dt overlay.
> 
> For example, in the Raspberry Pi repository, dt overlays are located in
> arch/arm/boot/dts/overlays.
> 
> Is there something similar for sunxi?

There's nothing similar either for RPi, sunxi, or any architecture in
upstream kernels.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
