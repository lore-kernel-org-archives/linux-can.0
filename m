From: Ratheendran <ba.rsrajeshwaran@tataelxsi.co.in>
Subject: Re: Regarding  J1939 support on freescale imx6 BSP
Date: Wed, 9 Apr 2014 19:50:28 +0530
Message-ID: <5345572C.60602@tataelxsi.co.in>
References: <533BAD63.80202@tataelxsi.co.in> <20140402183759.GA4780@vandijck-laurijssen.be> <533CFFB7.3020300@tataelxsi.co.in> <20140403133934.GA449@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-sg1lp0085.outbound.protection.outlook.com ([207.46.51.85]:51582
	"EHLO APAC01-SG1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932866AbaDIOVW (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 9 Apr 2014 10:21:22 -0400
In-Reply-To: <20140403133934.GA449@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Cc: linux-can@vger.kernel.org

Hi Kurt Van Dijck,

Thanks for your support.


I tried to implement your j1939stack on to Free-scale linux kernel 
3.0.15,I did this by manually copying and resolving the conflicts.

Now when I test some basic command following kernel documentation.
I am using iproute2 and can utilities compiled from your site. I get the 
following response.


./ip link set can0 j1939 on
RTNETLINK answers: Address family not supported by protocol
root@flex-oov:~/can# ./ip addr add dev can0 j1939 0x30
RTNETLINK answers: Operation not supported
root@flex-oov:~/can# ./ip addr del dev can0 j1939 0x30
RTNETLINK answers: Operation not supported



Also can use the can-test(https://gitorious.org/linux-can/can-tests) 
applications for validating j1939 socket,off-course with the J1929 
related modifications.

I am in the initial stage of experimentation so kindly give your 
valuable feedback.


Regards,
Ratheendran

On 4/3/2014 7:09 PM, Kurt Van Dijck wrote:
> Hi Ratheendran,
>
> On Thu, Apr 03, 2014 at 11:59:11AM +0530, Ratheendran wrote:
>> Hi Kurt,
>>
>> Thanks for your response,
>>
>> I just confirmed from my team ,we want j1939  stack into our
>> socketCAN layer.
> Great.
>
>> is j1939  stack part of mainstream kernel?
> no, you can find it at
> git@gitorious.org:linux-can/linux-can-j1939.git  ?
>
>> do I need to manually
>> update my Linux BSP with the source code and resolve the conflicts.
> If you already develop your kernel with git, then
> you would do something as:
> 	$ git remote add j1939git@gitorious.org:...
> 	$ git remote update j1939
> 	$ git merge j1939/j1939-v3.0b
>
> The latter command merges the j1939-v3.0b branch into your git repository.
> Several similar branches exists, which only differ in the mainline version
> that they forked off.
>
>> Going further, I want to implement this as a patch with the yocto
>> build, what is the best way to move ahead.
> I'm not enough familiar with Yocto to answer that.
>
> Kind regards,
> Kurt
>> Thanks,
>> Ratheendran
>>
>> On 4/3/2014 12:07 AM, Kurt Van Dijck wrote:
>>> Hi Ratheendran,
>>>
>>> On Wed, Apr 02, 2014 at 11:55:39AM +0530, Ratheendran wrote:
>>>> Hi All,
>>>>
>>>> I am new to Linux CAN module, want to know the how I can include
>>>> this J1939 support in my free-scale imx6 BSP. do you have a
>>>> ready-made patch.
>>>>
>>>> Please note, there is no requirement that the driver handle J1939
>>>> protocol, it must simply allow J1939 to be fully functional.
>>> Do you refer to my J1939 stack in the linux kernel tree that you can find at
>>> git@gitorious.org:linux-can/linux-can-j1939.git  ?
>>>
>>> Or is it something else that you seek?
>>> That is not clear to me.
>>>
>>> Kind regards,
>>> Kurt
>>> .
>>>
> .
>


