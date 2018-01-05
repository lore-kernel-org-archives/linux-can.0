From: David Miller <davem@davemloft.net>
Subject: Re: pull-request: can 2018-01-04
Date: Fri, 05 Jan 2018 13:48:39 -0500 (EST)
Message-ID: <20180105.134839.941290778276014203.davem@davemloft.net>
References: <20180104153355.11243-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([184.105.139.130]:35508 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752225AbeAESsl (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 5 Jan 2018 13:48:41 -0500
In-Reply-To: <20180104153355.11243-1-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org, kernel@pengutronix.de

From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Thu,  4 Jan 2018 16:33:51 +0100

> this is a pull request for net/master consisting of 4 patches.
> 
> The first patch is by Oliver Hartkopp, it improves the error checking
> during the creation of a vxcan link. Wolfgang Grandegger's patch for the
> gs_usb driver fixes the return value of the "set_bittiming" callback.
> Luu An Phu provides a patch for the flexcan driver to fix the frame
> length check in the flexcan_start_xmit() function. The last patch is by
> Martin Lederhilger for the ems_usb driver and improves the error
> reporting for error warning and passive frames.
 ...
>   ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-4.15-20180104

I think you meant:

	git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-4.15-20180104

Otherwise can I please have all of your private SSH keys? :-)

Pulled, thanks.
