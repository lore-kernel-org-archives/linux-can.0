From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH AUTOSEL 5.6 068/129] slcan: Don't transmit uninitialized
 stack data in padding
Date: Wed, 15 Apr 2020 19:22:43 +0200
Message-ID: <20200415172243.GA3661754@kroah.com>
References: <20200415113445.11881-1-sashal@kernel.org>
 <20200415113445.11881-68-sashal@kernel.org>
 <87h7xkisln.fsf@x220.int.ebiederm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:50063 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2410883AbgDORWs (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 15 Apr 2020 13:22:48 -0400
Content-Disposition: inline
In-Reply-To: <87h7xkisln.fsf@x220.int.ebiederm.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Richard Palethorpe <rpalethorpe@suse.com>, Kees Cook <keescook@chromium.org>, linux-can@vger.kernel.org, netdev@vger.kernel.org, security@kernel.org, wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net

On Wed, Apr 15, 2020 at 12:09:08PM -0500, Eric W. Biederman wrote:
> 
> How does this differ from Greg's backports of this patches?

His tool didn't catch that they are already in a merged tree, it's a few
steps later that this happens :)

greg k-h
