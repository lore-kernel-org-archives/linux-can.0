From: Andre Naujoks <nautsch2@gmail.com>
Subject: Re: [PATCH] do not use --symlink for autoreconf
Date: Wed, 02 Jul 2014 14:41:47 +0200
Message-ID: <53B3FE0B.7090205@gmail.com>
References: <1404303178-24608-1-git-send-email-nautsch2@gmail.com> <53B3F88E.2080202@pengutronix.de> <53B3FC62.1030209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:36386 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751538AbaGBMse (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 2 Jul 2014 08:48:34 -0400
Received: by mail-wi0-f172.google.com with SMTP id hi2so9556327wib.17
        for <linux-can@vger.kernel.org>; Wed, 02 Jul 2014 05:48:33 -0700 (PDT)
In-Reply-To: <53B3FC62.1030209@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc: socketcan@hartkopp.net

On 02.07.2014 14:34, Andre Naujoks wrote:
> On 02.07.2014 14:18, Marc Kleine-Budde wrote:
>> On 07/02/2014 02:12 PM, Andre Naujoks wrote:
>>> When packaging the can-utils, I understand, that the generation
>>> step for autoconf should be done beforehand. However using the
>>> --symlink option in the autoreconf step installs links instead of
>>> the actual files, which leads to a build failure when trying to
>>> build on another host with different autotools installed.
>>>
>>> Signed-off-by: Andre Naujoks <nautsch2@gmail.com>
>>
>> How do you package the can-utils? The usual steps are:
>>
>> ./autogen.sh ./configure make dist
> 
> with git archive. Something like
> 
> git archive --prefix=can-utils-`git describe --always --dirty`/ -o
> can-utils-`git describe --always --dirty`.tar.gz HEAD

... after which I unpack, autogen.sh and repack. Which is probably not
the sanest way of doing this, but should work.

> 
> I was not aware of the dist target. Why do I have to configure before
> creating the dist? Isn't the configure step just for adaptations for
> the build-host and target?
> 
> Andre
> 
>>
>> Marc
>>
> 

