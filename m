From: Timothy Vieregge <tvieregge@clearpathrobotics.com>
Subject: Re: J1939 support issiues
Date: Fri, 16 May 2014 14:54:48 -0400
Message-ID: <CAJdBzeBV4vngUvjNCLRre_n8bhu64=1k3-ugFDy5D9OKsv0cPQ@mail.gmail.com>
References: <CAJdBzeAkxtQKTcr863OJiLJkXyOOxTn-eEEUbCirA7gbQ95kYQ@mail.gmail.com>
	<20140516141441.GA13182@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:34115 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758163AbaEPSyt (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 16 May 2014 14:54:49 -0400
Received: by mail-ig0-f171.google.com with SMTP id c1so1159348igq.10
        for <linux-can@vger.kernel.org>; Fri, 16 May 2014 11:54:48 -0700 (PDT)
In-Reply-To: <20140516141441.GA13182@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Timothy Vieregge <tvieregge@clearpathrobotics.com>, linux-can@vger.kernel.org

Ahh, I had the wrong branch checked out in git. Changing to the
correct branch fixed it, thanks.



On Fri, May 16, 2014 at 10:14 AM, Kurt Van Dijck
<dev.kurt@vandijck-laurijssen.be> wrote:
> Hey,
>
> On Thu, May 15, 2014 at 04:00:22PM -0400, Timothy Vieregge wrote:
>> I'm trying to get J1939 support for an Ubuntu machine, and I'm running
>> into some issues.
>>
>> When I try to compile the can-j1939-utils (against ubuntu-lts-3.8
>> kernel) I am getting an error.
>>
>> "libj1939.h:3:29 fatal error: linux/can/j1939.h: No such file or directory"
>
> The file include/linux/can/j1939.h should be in your can-j1939-utils repository.
> Can you verify?
>
>>
>> I can see the file in the the linux-can-j1939 repo, but not in my
>> merged source, or in /usr/include on the target machine. Any idea
>> what's going wrong?
>
> Maybe your host system does not want to look in ./include
> directory for system include files.
> Can you grab the command that your build process executes?
>
> Kind regards,
> Kurt
