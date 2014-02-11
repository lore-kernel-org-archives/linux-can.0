From: Olivier Sobrie <olivier@sobrie.be>
Subject: Re: [PATCH] can: kvaser_usb: check number of channels returned by HW
Date: Tue, 11 Feb 2014 13:33:49 +0100
Message-ID: <20140211123218.GA8818@hposo>
References: <1392112884-27101-1-git-send-email-olivier@sobrie.be>
 <52F9F6F5.6090209@pengutronix.de>
Reply-To: Olivier Sobrie <olivier@sobrie.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ea0-f173.google.com ([209.85.215.173]:51567 "EHLO
	mail-ea0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750767AbaBKMdy (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 11 Feb 2014 07:33:54 -0500
Received: by mail-ea0-f173.google.com with SMTP id d10so3668931eaj.4
        for <linux-can@vger.kernel.org>; Tue, 11 Feb 2014 04:33:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <52F9F6F5.6090209@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

Hello Marc,

On Tue, Feb 11, 2014 at 11:09:57AM +0100, Marc Kleine-Budde wrote:
> On 02/11/2014 11:01 AM, Olivier Sobrie wrote:
> > It is needed to check the number of channels returned by the HW
> > because it cannot be greater than MAX_NET_DEVICES otherwise
> > it will crash.
> >
> > Signed-off-by: Olivier Sobrie <olivier@sobrie.be>
> 
> Does this bug occur on any kvaser USB hardware?

I never see it with the devices I have and nobody reported me a problem
regarding this. I found this bug by chance while I was looking to add
support for Kvaser device from usbcanII family.

> However, I think, I'll add stable on Cc

Good idea :-)
Thank you,

-- 
Olivier
