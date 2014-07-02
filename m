From: Andre Naujoks <nautsch2@gmail.com>
Subject: Re: [PATCH] do not use --symlink for autoreconf
Date: Wed, 02 Jul 2014 14:34:42 +0200
Message-ID: <53B3FC62.1030209@gmail.com>
References: <1404303178-24608-1-git-send-email-nautsch2@gmail.com> <53B3F88E.2080202@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:45863 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751775AbaGBMmU (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 2 Jul 2014 08:42:20 -0400
Received: by mail-we0-f174.google.com with SMTP id u57so11356439wes.33
        for <linux-can@vger.kernel.org>; Wed, 02 Jul 2014 05:42:19 -0700 (PDT)
In-Reply-To: <53B3F88E.2080202@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc: socketcan@hartkopp.net

On 02.07.2014 14:18, Marc Kleine-Budde wrote:
> On 07/02/2014 02:12 PM, Andre Naujoks wrote:
>> When packaging the can-utils, I understand, that the generation
>> step for autoconf should be done beforehand. However using the
>> --symlink option in the autoreconf step installs links instead of
>> the actual files, which leads to a build failure when trying to
>> build on another host with different autotools installed.
>> 
>> Signed-off-by: Andre Naujoks <nautsch2@gmail.com>
> 
> How do you package the can-utils? The usual steps are:
> 
> ./autogen.sh ./configure make dist

with git archive. Something like

git archive --prefix=can-utils-`git describe --always --dirty`/ -o
can-utils-`git describe --always --dirty`.tar.gz HEAD

I was not aware of the dist target. Why do I have to configure before
creating the dist? Isn't the configure step just for adaptations for
the build-host and target?

Andre

> 
> Marc
> 

