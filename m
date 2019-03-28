From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH net-next] can: kvaser_usb: Use struct_size() in
 alloc_candev()
Date: Thu, 28 Mar 2019 12:58:48 -0500
Message-ID: <5760e0a4-101d-9ff4-b5e8-046b7dd38d1b@embeddedor.com>
References: <20190208031035.GA2665@embeddedor>
 <b736a7b3-819a-a471-c767-2997354e70e4@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b736a7b3-819a-a471-c767-2997354e70e4@pengutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, "David S. Miller" <davem@davemloft.net>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

Hi Marc,

On 2/26/19 1:52 AM, Marc Kleine-Budde wrote:
> On 2/8/19 4:10 AM, Gustavo A. R. Silva wrote:
>> One of the more common cases of allocation size calculations is finding
>> the size of a structure that has a zero-sized array at the end, along
>> with memory for some number of elements for that array. For example:
>>
>> struct foo {
>>     int stuff;
>>     void *entry[];
>> };
>>
>> instance = alloc(sizeof(struct foo) + count * sizeof(void *));
>>
>> Instead of leaving these open-coded and prone to type mistakes, we can
>> now use the new struct_size() helper:
>>
>> instance = alloc(struct_size(instance, entry, count));
>>
>> This code was detected with the help of Coccinelle.
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> 
> Applied to linux-can-next.
> 

I noticed this patch is not in linux-next.

I wonder if you actually applied it to your tree.

Thanks
--
Gustavo
