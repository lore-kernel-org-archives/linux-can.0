From: Florian Feldbauer <florian@ep1.ruhr-uni-bochum.de>
Subject: Re: Writing socketCAN module for my own hardware
Date: Fri, 10 Oct 2014 10:09:22 +0200
Message-ID: <54379432.3040009@ep1.ruhr-uni-bochum.de>
References: <53E9C774.3040401@ep1.ruhr-uni-bochum.de> <53E9CF27.90400@pengutronix.de> <53E9D6F3.4050206@ep1.ruhr-uni-bochum.de> <53E9E614.7060303@pengutronix.de> <542BACC0.4050707@ep1.ruhr-uni-bochum.de> <542BB21B.4030200@pengutronix.de> <542BF456.3030201@ep1.ruhr-uni-bochum.de> <542BF687.1000800@pengutronix.de> <5436A482.4040001@ep1.ruhr-uni-bochum.de> <5436B443.10606@pengutronix.de> <54378E35.6000205@ep1.ruhr-uni-bochum.de> <54379389.5040005@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mi.ruhr-uni-bochum.de ([134.147.64.53]:60126 "HELO
	mx4.rz.ruhr-uni-bochum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751389AbaJJIJZ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 10 Oct 2014 04:09:25 -0400
In-Reply-To: <54379389.5040005@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

On 10/10/2014 10:06 AM, Marc Kleine-Budde wrote:
> On 10/10/2014 09:43 AM, Florian Feldbauer wrote:
>>>> Although I can see at the scope, that reading register 0 of the SJ=
A1000
>>>> returns the value 1 as it should be.
>>>> Also, it seems that there is some kind of endless loop reading thi=
s
>>>> register.
>>> No, just a loop of up to 100 :)
>> Maybe it's correlated with the issue that the message
>> [  129.210423] sja1000_raspi sja1000_raspi.0 can0: bit-timing not ye=
t
>> appears over and over again in dmesg, but register 0 is definitely
>> read more than 100 times...
> As mentioned earlier, you have probably a mechanism running on your
> system, that tries to enable the CAN interface. Bringing up the
> interface without a set bit-rate is not allowed.
>
> [...]
>
>>>> Any Ideas why the first initialization of the kernel module doesn'=
t
>>>> work?
>>>> When is the probe function of the module actually called?
>>> As soon as there is a matching driver//device combination on a bus.
>>> Looking at your driver, it's racy. You should not do any hardware s=
etup
>>> in the init function.
>> Ok...I moved the whole configuration of the GPIOs into the probe
>> function (instead of the init)
>> and now it works! Thanks!
>>
>> Now I only have to solve the problem, that bringing the interface do=
wn
>> is not possible....
>> Always need to reboot just to change bitrate is no fun.
>> Maybe I should consult the Raspberry community, if there is some kin=
d of
>> network manager...
> What kind of distribution are you using?
raspbian wheezy, version from 2014-09-09
>
> Marc
>


--=20
----------------------------------------
| Dr. Florian Feldbauer                |
|                                      |
| Helmholtz-Institut Mainz /           |
| Johannes Gutenberg-Universit=C3=A4t Mainz |
| Johann-Joachim-Becher-Weg 36         |
| D-55128 Mainz                        |
|                                      |
| Office: SB1 / 00-213                 |
| Phone:  (+49)6131 / 39-29605         |
----------------------------------------

