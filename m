From: David Miller <davem@davemloft.net>
Subject: Re: pull-request: can 2017-12-01
Date: Sun, 03 Dec 2017 09:58:53 -0500 (EST)
Message-ID: <20171203.095853.826220613574224436.davem@davemloft.net>
References: <20171201141739.5816-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([184.105.139.130]:35942 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752142AbdLCO6z (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 3 Dec 2017 09:58:55 -0500
In-Reply-To: <20171201141739.5816-1-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org, kernel@pengutronix.de

From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Fri,  1 Dec 2017 15:17:30 +0100

> this is a pull for net consisting of nine patches.
> 
> The first three patches are by Jimmy Assarsson for the kvaser_usb driver
> and add the missing free()s in some error path, a signed/unsigned
> comparison and ratelimit the error messages in case of incomplete
> messages. Oliver Stäbler's patch for the ti_hecc driver fix the napi
> poll function's return value. The return values of the probe function of
> the peak_canfd and peak_pci PCI drivers are fixed by Stephane Grosjean's
> patch. Two patches by me for the flexcan driver update the
> bugs/features/quirks overview table and fix the error state transition
> for the VF610 SoC. The two patches by Martin Kelly for the mcba_usb
> driver fix a typo and a device disconnect bug.

Pulled, thanks Marc.
