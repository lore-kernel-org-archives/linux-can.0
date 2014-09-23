From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 2/4] Consolidate and unify state change handling
Date: Wed, 24 Sep 2014 00:31:49 +0200
Message-ID: <5421F4D5.5030709@hartkopp.net>
References: <541B0792.5030002@marel.com> <541C9BD8.8070303@grandegger.com> <541EE4E9.9010506@marel.com> <541EEF28.5000103@grandegger.com> <541F0A80.7060800@marel.com> <5421D92C.80906@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:53788 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756867AbaIWWb4 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 23 Sep 2014 18:31:56 -0400
In-Reply-To: <5421D92C.80906@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Andri Yngvason <andri.yngvason@marel.com>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

On 09/23/2014 10:33 PM, Wolfgang Grandegger wrote:
> On 09/21/2014 07:27 PM, Andri Yngvason wrote:


>> PS.: I must admit that I don't actually know why it's useful to know which
>> error counter changed; tx or rx. I think it would be much simpler to send
>> the max of both and be done with it. Can anyone point out a case where this
>> helps?
> 
> I agree that it would be much simpler not to distinguish between rx and
> tx state changes. This is for historical reasons. Oliver, do you
> remember why we adapted that solution?
> 

No. Indeed I was not even aware of the fact that error counters should be set
into any kind of relation.

When the error counters change, the error message should be fired.
And when the thresholds e.g. for CAN_ERR_CRTL_*X_WARNING are triggered these
flags should be set accordingly.

So can_state errcount_to_state() makes perfectly sense.

But I don't know why to compare tx error counters to rx error counters either.

Regards,
Oliver


