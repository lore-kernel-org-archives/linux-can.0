From: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH AUTOSEL 5.6 068/129] slcan: Don't transmit uninitialized
 stack data in padding
Date: Wed, 15 Apr 2020 20:04:09 -0400
Message-ID: <20200416000409.GM1068@sasha-vm>
References: <20200415113445.11881-1-sashal@kernel.org>
 <20200415113445.11881-68-sashal@kernel.org>
 <87h7xkisln.fsf@x220.int.ebiederm.org>
 <20200415172243.GA3661754@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729647AbgDPAEK (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 15 Apr 2020 20:04:10 -0400
Content-Disposition: inline
In-Reply-To: <20200415172243.GA3661754@kroah.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Greg KH <greg@kroah.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Richard Palethorpe <rpalethorpe@suse.com>, Kees Cook <keescook@chromium.org>, linux-can@vger.kernel.org, netdev@vger.kernel.org, security@kernel.org, wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net

On Wed, Apr 15, 2020 at 07:22:43PM +0200, Greg KH wrote:
>On Wed, Apr 15, 2020 at 12:09:08PM -0500, Eric W. Biederman wrote:
>>
>> How does this differ from Greg's backports of this patches?
>
>His tool didn't catch that they are already in a merged tree, it's a few
>steps later that this happens :)

My process for doing these takes a day or two (or three) to build test,
test, and send mails. Sometimes Greg beats me to it :)

-- 
Thanks,
Sasha
