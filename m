From: Olivier Sobrie <olivier@sobrie.be>
Subject: Re: [PATCH] can: kvaser_usb: fix usb endpoints detection
Date: Mon, 28 Oct 2013 13:08:08 +0100
Message-ID: <20131028120808.GA20686@hposo>
References: <1382908073-6865-1-git-send-email-olivier@sobrie.be>
 <526E2D96.5050106@pengutronix.de>
Reply-To: Olivier Sobrie <olivier@sobrie.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ee0-f50.google.com ([74.125.83.50]:39067 "EHLO
	mail-ee0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754442Ab3J1MIR (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 28 Oct 2013 08:08:17 -0400
Received: by mail-ee0-f50.google.com with SMTP id l10so3376777eei.9
        for <linux-can@vger.kernel.org>; Mon, 28 Oct 2013 05:08:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <526E2D96.5050106@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org

On Mon, Oct 28, 2013 at 10:25:42AM +0100, Marc Kleine-Budde wrote:
> On 10/27/2013 10:07 PM, Olivier Sobrie wrote:
> > Some devices, like the Kvaser Memorator Professional, have several
> > bulk in endpoints. Only the first one found should be used by the
> > driver. The same holds for the bulk out endpoint.
> 
> Is this a critical fix? Does the hardware work without this patch?
> Should I add stable on Cc?

Yes it is critical for all devices like Kvaser Memorator Pro.
Without this patch these devices don't work.
So yes, you can add stable in cc.

Kr,

-- 
Olivier
