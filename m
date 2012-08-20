From: Stephen Hemminger <shemminger@vyatta.com>
Subject: Re: [PATCH iproute2 2/2] em_canid: Ematch used to classify CAN
 frames according to their identifiers
Date: Mon, 20 Aug 2012 13:13:34 -0700
Message-ID: <20120820131334.70d39b62@nehalam.linuxnetplumber.net>
References: <1343745981-14248-1-git-send-email-lisovy@gmail.com>
	<1343745981-14248-2-git-send-email-lisovy@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.vyatta.com ([76.74.103.46]:54987 "EHLO mail.vyatta.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753725Ab2HTUNw (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 20 Aug 2012 16:13:52 -0400
In-Reply-To: <1343745981-14248-2-git-send-email-lisovy@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Rostislav Lisovy <lisovy@gmail.com>
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org, pisa@cmp.felk.cvut.cz, sojkam1@fel.cvut.cz

On Tue, 31 Jul 2012 16:46:21 +0200
Rostislav Lisovy <lisovy@gmail.com> wrote:

> This ematch enables effective filtering of CAN frames (AF_CAN) based
> on CAN identifiers with masking of compared bits. Implementation
> utilizes bitmap based classification for standard frame format (SFF)
> which is optimized for minimal overhead.
> 
> Signed-off-by: Rostislav Lisovy <lisovy@gmail.com>

Since this doesn't have any conflicts (unlike other CAN filtering),
I applied it for 3.6 version.

