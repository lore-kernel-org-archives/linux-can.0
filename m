From: Yegor Yefremov <yegor_sub1@visionsystems.de>
Subject: Re: [PATCH 2/2] can-utils: add Makefile for Android build system
Date: Thu, 22 Mar 2012 11:15:42 +0100
Message-ID: <4F6AFBCE.40305@visionsystems.de>
References: <1332236859-22204-1-git-send-email-yegorslists@googlemail.com> <1332236859-22204-2-git-send-email-yegorslists@googlemail.com> <4F685737.6090700@pengutronix.de>
Reply-To: yegor_sub1@visionsystems.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ns.vscom.de ([62.145.30.242]:39579 "EHLO mail.visionsystems.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750920Ab2CVKP7 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 22 Mar 2012 06:15:59 -0400
In-Reply-To: <4F685737.6090700@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: yegorslists@googlemail.com, linux-can@vger.kernel.org

Am 20.03.2012 11:08, schrieb Marc Kleine-Budde:
> On 03/20/2012 10:47 AM, yegorslists@googlemail.com wrote:
>> From: Yegor Yefremov <yegorslists@googlemail.com>
>>
>> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
> 
> Looks a bit ugly to me (as a non Android developer) repeating some
> variables so many times. Is it usual to write android makefiles like this?

Yes, it is really ugly :-( I'd like Android to have Buildroot like build system, so that native autotools/cmake/ etc. could be used directly. I've looked at other external packages in Android and took their Android.mk as a template.
 
> There are some trailing whitespaces. No need to recommit the patch, I've
> removed them.

Working with quilt was easier regarding trailing white spaces. I'm looking for git way of removing them.

I've seen the first patch committed, this is one is still not committed as far as I can see. Do I need to rework something?

Yegor

