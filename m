From: Andre Naujoks <nautsch2@gmail.com>
Subject: Re: [PATCH] do not use --symlink for autoreconf
Date: Wed, 02 Jul 2014 16:09:14 +0200
Message-ID: <53B4128A.80908@gmail.com>
References: <1404303178-24608-1-git-send-email-nautsch2@gmail.com> <53B3F88E.2080202@pengutronix.de> <53B3FC62.1030209@gmail.com> <53B3FE0B.7090205@gmail.com> <53B40204.7040400@pengutronix.de> <53B403D5.9070406@pengutronix.de> <53B40455.80202@pengutronix.de> <53B40D80.10706@gmail.com> <53B4119B.3090804@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:45174 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753444AbaGBOPH (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 2 Jul 2014 10:15:07 -0400
Received: by mail-wi0-f177.google.com with SMTP id r20so577889wiv.16
        for <linux-can@vger.kernel.org>; Wed, 02 Jul 2014 07:15:05 -0700 (PDT)
In-Reply-To: <53B4119B.3090804@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc: socketcan@hartkopp.net

On 02.07.2014 16:05, Marc Kleine-Budde wrote:
> On 07/02/2014 03:47 PM, Andre Naujoks wrote:
>> On 02.07.2014 15:08, Marc Kleine-Budde wrote:
>>> On 07/02/2014 03:06 PM, Marc Kleine-Budde wrote:
>>>> On 07/02/2014 02:58 PM, Marc Kleine-Budde wrote:
>>>>> On 07/02/2014 02:41 PM, Andre Naujoks wrote:
>>>>>> On 02.07.2014 14:34, Andre Naujoks wrote:
>>>>>>> On 02.07.2014 14:18, Marc Kleine-Budde wrote:
>>>>>>>> On 07/02/2014 02:12 PM, Andre Naujoks wrote:
>>>>>>>>> When packaging the can-utils, I understand, that
>>>>>>>>> the generation step for autoconf should be done
>>>>>>>>> beforehand. However using the --symlink option in
>>>>>>>>> the autoreconf step installs links instead of the
>>>>>>>>> actual files, which leads to a build failure when
>>>>>>>>> trying to build on another host with different
>>>>>>>>> autotools installed.
>>>>>>>>> 
>>>>>>>>> Signed-off-by: Andre Naujoks <nautsch2@gmail.com>
>>>>>>>> 
>>>>>>>> How do you package the can-utils? The usual steps
>>>>>>>> are:
>>>>>>>> 
>>>>>>>> ./autogen.sh ./configure make dist
>>>>>>> 
>>>>>>> with git archive. Something like
>>>>>>> 
>>>>>>> git archive --prefix=can-utils-`git describe --always 
>>>>>>> --dirty`/ -o can-utils-`git describe --always 
>>>>>>> --dirty`.tar.gz HEAD
>>>>>> 
>>>>>> ... after which I unpack, autogen.sh and repack. Which
>>>>>> is probably not the sanest way of doing this, but should
>>>>>> work.
>>>>> 
>>>>> This is why you get the problems with the links....
>>>> 
>>>> Try something like this instead (untested, though):
>>>> 
>>>> project=can-utils-`git describe --always --dirty` git
>>>> archive --prefix=$project/ -o $project.tar HEAD tar xf
>>>> $project.tar cd $project ./autogen.sh cd .. tar -rhf
>>>> $project.tar \ $project/GNUmakefile.in $project/aclocal.m4 
>>>> $project/autom4te.cache/
>>> ^^^^^^^^^^^^^^^^^^^^^^^^
>> 
>> This is all nice and all, and I appreciate it, but why is the 
>> --symlink parameter there in the first place? I see no benefit
>> from using it. It just makes things harder if you do it "the
>> normal way".
> 
> Yes, I think the autotools/git interaction can be improved.
> 
>> Another thing is, that you need a host with all build
>> dependencies resolved (i.e. configure completes) just to generate
>> an unbuild package. This might not be a problem now (or ever),
>> but why put in such a pitfall, when it is not needed?
> 
> For now I've applied your patch.

Great! Thank you. :-)

> 
> Thanks, Marc
> 

