From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v1 1/9] can: af_can: export can_sock_destruct()
Date: Tue, 12 Nov 2019 19:24:54 +0100
Message-ID: <5e561756-26b4-9a71-8fe2-c876e0e7d1af@hartkopp.net>
References: <20191112111600.18719-1-o.rempel@pengutronix.de>
 <20191112111600.18719-2-o.rempel@pengutronix.de>
 <20191112113724.pff6atmyii5ri4my@pengutronix.de>
 <1da06748-6233-b65e-9b02-da5a867a4ecb@pengutronix.de>
 <20191112114539.zjluqnpo3cynhssi@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191112114539.zjluqnpo3cynhssi@pengutronix.de>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, dev.kurt@vandijck-laurijssen.be, wg@grandegger.com, netdev@vger.kernel.org, kernel@pengutronix.de, linux-can@vger.kernel.org
List-Id: linux-can.vger.kernel.org



On 12/11/2019 12.45, Uwe Kleine-König wrote:
> Hello Marc,
> 
> On Tue, Nov 12, 2019 at 12:39:27PM +0100, Marc Kleine-Budde wrote:
>> On 11/12/19 12:37 PM, Uwe Kleine-König wrote:
>>> On Tue, Nov 12, 2019 at 12:15:52PM +0100, Oleksij Rempel wrote:
>>>> +EXPORT_SYMBOL(can_sock_destruct);
>>>
>>> If the users are only expected to be another can module, it might make
>>> sense to use a namespace here?!
>>
>> How?
> 
> Use
> 
> 	EXPORT_SYMBOL_NS(can_sock_destruct, CAN)
> 
> instead of the plain EXPORT_SYMBOL, and near the declaration of
> can_sock_destruct or in the source that makes use of the symbol add:
> 
> 	MODULE_IMPORT_NS(CAN);
> 
> See https://lwn.net/Articles/760045/ for some details.

Looks nice! Good idea!

But I would tend to introduce the symbol namespaces for this and the 
other (existing) symbols via can-next and not within this patch set that 
addresses the j1939 fixes.

Best regards,
Oliver
