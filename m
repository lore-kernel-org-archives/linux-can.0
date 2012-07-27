From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH iproute2 v2 0/3] CAN Filter/Classifier
Date: Fri, 27 Jul 2012 16:06:50 +0200
Message-ID: <5012A07A.6030302@hartkopp.net>
References: <1343383363-6174-1-git-send-email-mkl@pengutronix.de> <50129E17.7030602@hartkopp.net> <50129E9E.8010806@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <50129E9E.8010806@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org, lartc@vger.kernel.org, pisa@cmp.felk.cvut.cz, sojkam1@fel.cvut.cz, lisovy@gmail.com
List-Id: linux-can.vger.kernel.org

On 27.07.2012 15:58, Marc Kleine-Budde wrote:

> On 07/27/2012 03:56 PM, Oliver Hartkopp wrote:
>> On 27.07.2012 12:02, Marc Kleine-Budde wrote:
>>
>>> I'm reposting Rostislav's iproute2 patches, as Stephen requested,
>>> during the v3.6 merge window with the corresponding kernel patches
>>> already applied.
>>
>>
>> Hallo Marc,
>>
>> thanks for tracking these iproute2 patches.
>>
>> Btw. i think these patches address the original implementation from Rostislav
>> using the CAN classifier. The review lead to a completely new implementation
>> using ematch. Therefore this patch series is outdated AFAICS.
>>
>> @Rostislav: Am i correct here?
> 
> Has someone started working on this, or already new patches?
> 


Yes. Rostislav worked on this iproute2 extension for his own tests:

https://rtime.felk.cvut.cz/gitweb/lisovros/iproute2_canprio.git/shortlog/refs/heads/em_can

I assume there will be some patches posted in the next time.

Regards,
Oliver
