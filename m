From: Timothy Vieregge <tvieregge@clearpathrobotics.com>
Subject: Re: Kernel Oops when setting j1939 device on
Date: Wed, 21 May 2014 17:01:44 -0400
Message-ID: <CAJdBzeA8=UVGa0yR2AUexEJjhtcd16P=iwdoM8+MqM=UHvfdCw@mail.gmail.com>
References: <CAJdBzeATNb2pBOdp5bpx86Bw+K00wYwjgFOuRGbtZSPXvMoBuQ@mail.gmail.com>
	<20140520201654.GD25701@vandijck-laurijssen.be>
	<CAJdBzeBEL=pz4imZvywVwZsjj3o7Gh6JshgKrm3aSbYOjMiZ6Q@mail.gmail.com>
	<20140521191215.GA581@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:34936 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752066AbaEUVBp (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 21 May 2014 17:01:45 -0400
Received: by mail-ig0-f178.google.com with SMTP id hl10so2669905igb.5
        for <linux-can@vger.kernel.org>; Wed, 21 May 2014 14:01:45 -0700 (PDT)
In-Reply-To: <20140521191215.GA581@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Timothy Vieregge <tvieregge@clearpathrobotics.com>, linux-can@vger.kernel.org

On Wed, May 21, 2014 at 3:12 PM, Kurt Van Dijck
<dev.kurt@vandijck-laurijssen.be> wrote:
> Hey Timothy,
>
> On Tue, May 20, 2014 at 04:46:10PM -0400, Timothy Vieregge wrote:
>> I compiled the j1939-v3.8 branch into the kernel.
>
> To be honest, I do not really understand what you did exactly here.
> Did you:
> * use an ubuntu kernel and compiled the new kernel next to it.
> * use an ubuntu kernel and compiled the new kernel with the .config
>   from that sock kernel.
> * Use some git repository of the ubuntu kernel and merged can-j1939 into that.
> * not use anything of an ubuntu kernel.
>
> Can you clarify.

Re-reading that it was much more confusing than I intended...
What I did was merge can-j1939 into the ubuntu git repo.

>> Also, I'm using the j1939-v3.6 branch of iproute2-j1939.
>>
>> I didn't specifically replace any of the modules, I simply loaded the
>> ones that were present in the custom kernel (can, vcan and can_raw).
>
> 1. did you "insmod xxx" or "modprobe xxx"
> 2. Didn't you load can-j1939?

I used modprobe.

I did not. Unsurprisingly that fixed my problems.
I'll update the elinux wiki slightly once I have access. That should
avoid some of
the questions like this in the future.

>> Although I assume that those were changed during the compilation.
>>
>> Let me know if you want any more of my system info. The behaviour was
>> reproducible in a clean VM
>
> The thing is, I can't yet reproduce the problem on my 3.8.2 kernel.
> So I keep looking around.
>
> Kind regards,
> Kurt
