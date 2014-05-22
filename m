From: Timothy Vieregge <tvieregge@clearpathrobotics.com>
Subject: Re: Kernel Oops when setting j1939 device on
Date: Thu, 22 May 2014 15:19:09 -0400
Message-ID: <CAJdBzeC_G2vSJQn8hHjKkRDEc_Htyp8S1zXPr2mQzL+vDCbs5w@mail.gmail.com>
References: <CAJdBzeATNb2pBOdp5bpx86Bw+K00wYwjgFOuRGbtZSPXvMoBuQ@mail.gmail.com>
	<20140520201654.GD25701@vandijck-laurijssen.be>
	<CAJdBzeBEL=pz4imZvywVwZsjj3o7Gh6JshgKrm3aSbYOjMiZ6Q@mail.gmail.com>
	<20140521191215.GA581@vandijck-laurijssen.be>
	<CAJdBzeA8=UVGa0yR2AUexEJjhtcd16P=iwdoM8+MqM=UHvfdCw@mail.gmail.com>
	<20140522092927.GA23173@vandijck-laurijssen.be>
	<537DCA08.4040000@artisandeveloppeur.fr>
	<20140522113920.GB23173@vandijck-laurijssen.be>
	<537DE3B7.7080302@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:38199 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751429AbaEVTTK (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 22 May 2014 15:19:10 -0400
Received: by mail-ie0-f180.google.com with SMTP id tp5so3891118ieb.25
        for <linux-can@vger.kernel.org>; Thu, 22 May 2014 12:19:09 -0700 (PDT)
In-Reply-To: <537DE3B7.7080302@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Maxime Jayat <maxime@artisandeveloppeur.fr>, linux-can@vger.kernel.org

On Thu, May 22, 2014 at 7:47 AM, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 05/22/2014 01:39 PM, Kurt Van Dijck wrote:
>> Hey Maxime & Timothy,
>>
>> On Thu, May 22, 2014 at 11:57:28AM +0200, Maxime Jayat wrote:
>> [...]
>>>
>>> I've hit the same problem as Timothy in the past. I've looked into it
>>> and the reason for it is that the code in
>>> https://gitorious.org/linux-can/linux-can-j1939/source/j1939-v3.8:net/can/af_can.c#L1020-1041
>>> is different from the code in
>>> https://gitorious.org/linux-can/can-j1939-modules/source/master:net/can/af_can.c#L1169
>>> and the former still has a bug that is fixed in the latter in can_validate_link_af.
>>>
>>> In particular:
>>>              cp = can_get_proto(nla_type(prot));
>>>              if (!cp || !cp->rtnl_link_ops)
>>>                      ret = -EPROTONOSUPPORT;
>>>              else if (!cp->rtnl_link_ops->validate_link_af)
>>>                      ret = 0;
>>>              else
>>>                      ret = cp->rtnl_link_ops->validate_link_af(dev, prot);
>>>              can_put_proto(cp);
>>>              if (ret < 0)
>>>                      return ret;
>>>
>>> doesn't end well for can_put_proto when can_get_proto returns NULL.
>>
>> That explains things, but I'm still puzzled why it did work on my machines.
>> Maybe some other config option makes the call to module_put inside can_put_proto
>> behave different?
>>
>> Anyway, you pointed to a real problem, and I promptly pushed a patch for it.
>> Timothy, pulling in git and building again should really solve the problem
>> that the systems fails. You will still need to load can-j1939, but you will
>> informed better about this, and the system itself should not fail.

It's now behaving as expected

>>>
>>> I find it not very clear to see what is the most up-to-date repo for J1939
>>> and whether all the branches in linux-can-j1939 are supposed to be maintained
>>> along with can-j1939-modules.
>>
>> out-of-tree modules become old-fashioned with the use of git.
>> can-j1939-modules is a remainder of the state we were in on berlios using SVN.
>> I don't intend to spend much effort on the out-of-tree modules ...
>
> If you don't maintain the modules anymore, can you delete the repo? Or
> add a prefix like -depreaced.

I've added some info to the wiki that should clear stuff up a bit.
