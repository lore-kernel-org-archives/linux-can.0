From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Subject: Re: [PATCH 1/5] can: kvaser_usb: Avoid double free on URB submission
 failures
Date: Mon, 9 Mar 2015 08:32:54 -0400
Message-ID: <20150309123254.GA18661@linux>
References: <20150226152011.GA6075@linux>
 <54F6CD41.8050703@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:44955 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751061AbbCIMjh (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 9 Mar 2015 08:39:37 -0400
Content-Disposition: inline
In-Reply-To: <54F6CD41.8050703@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Olivier Sobrie <olivier@sobrie.be>, Oliver Hartkopp <socketcan@hartkopp.net>, Wolfgang Grandegger <wg@grandegger.com>, Andri Yngvason <andri.yngvason@marel.com>, Linux-CAN <linux-can@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

Hi Marc,

(Sorry for the late reply as I was out of town!)

On Wed, Mar 04, 2015 at 10:15:45AM +0100, Marc Kleine-Budde wrote:
> On 02/26/2015 04:20 PM, Ahmed S. Darwish wrote:
> > From: Ahmed S. Darwish <ahmed.darwish@valeo.com>
> > 
> > Upon a URB submission failure, the driver calls usb_free_urb()
> > but then manually frees the URB buffer by itself.  Meanwhile
> > usb_free_urb() has alredy freed out that transfer buffer since
> > we're the only code path holding a reference to this URB.
> > 
> > Remove two of such invalid manual free().
> > 
> > Signed-off-by: Ahmed S. Darwish <ahmed.darwish@valeo.com>
> 
> Applied 1+2 and added stable on Cc. Can you please shuffle the remaining
> patches, so that patch 5 comes first, then 4 and 3 as the last patch. As
> 5 is a bugfix it should go into stable, while 3 isn't.
>
> You can base your series on the can/testing branch.
> 

Did not care much about the bugfixes order this time as the patches
themselves will not apply cleanly (or at all) to -stable due to the
addition of UsbCAN-II code, which all -stable kernels do not have.
Thus I guess I'll need to submit a different patch series for -stable
with patches 1, 2, and 5 -- rebased.

Nonetheless, you're correct that having the bugfixes (1,2,5), then the
optimization (4), then the janitorial fix (3) is the logical order for
history & bisection sake. So.. I'll re-order the patches, individually
test with the new order, and re-submit over can/testing.

Thanks,
Darwish
