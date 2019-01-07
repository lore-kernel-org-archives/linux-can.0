From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v3] can: gw: ensure DLC boundaries after CAN frame
 modification
Date: Mon, 7 Jan 2019 13:14:44 +0100
Message-ID: <210dc841-f31d-5e4b-d292-eecba0c085d9@hartkopp.net>
References: <20190104145526.28492-1-mkl@pengutronix.de>
 <20190104.134126.1987487762349795104.davem@davemloft.net>
 <d07efb4f-462f-3edb-04d9-5ab632b972cd@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <d07efb4f-462f-3edb-04d9-5ab632b972cd@pengutronix.de>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>, David Miller <davem@davemloft.net>
Cc: linux-can@vger.kernel.org, kernel@pengutronix.de, netdev@vger.kernel.org, ieatmuttonchuan@gmail.com, meissner@suse.de, mkubecek@suse.cz, stable@vger.kernel.org
List-Id: linux-can.vger.kernel.org

Hello Marc,

On 1/5/19 11:56 AM, Marc Kleine-Budde wrote:
> On 1/4/19 10:41 PM, David Miller wrote:
>> From: Marc Kleine-Budde <mkl@pengutronix.de>
>> Date: Fri,  4 Jan 2019 15:55:26 +0100
>>
>> Marc, do you want me to apply this directly to my net tree?
> 
> No, I'll send a pull request.
> 
> Thanks,
> Marc

I was still on vacation last week an my environment at home was not that 
amused - but I really tried to fix this CVE as fast as possible in the 
best way we could.

Now the patch is nearly 70h hanging around and 48h since you announced 
to send a pull request.

I don't get it. Wouldn't it been better when you just wrote one sentence 
so that the patch could go upstream already on Saturday?

Regards,
Oliver
