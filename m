From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] can: Replace zero-length array with flexible-array
Date: Wed, 3 Jun 2020 19:58:35 -0500
Message-ID: <73903bc6-afb7-f30e-28ef-065d41c6ace6@embeddedor.com>
References: <20200507185118.GA14022@embeddedor>
 <0420f571-2d6a-c830-2029-8da60e3c2094@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0420f571-2d6a-c830-2029-8da60e3c2094@hartkopp.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Oliver Hartkopp <socketcan@hartkopp.net>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

Hi Oliver,

Sorry for the late reply. I totally lost track of this thread. :/
Please, see my comments below...

On 5/12/20 08:30, Oliver Hartkopp wrote:
> 
> 
> On 2020-05-07 20:51, Gustavo A. R. Silva wrote:
>> The current codebase makes use of the zero-length array language
>> extension to the C90 standard, but the preferred mechanism to declare
>> variable-length types such as these ones is a flexible array member[1][2],
>> introduced in C99:
>>
>> struct foo {
>>          int stuff;
>>          struct boo array[];
>> };
>>
>> By making use of the mechanism above, we will get a compiler warning
>> in case the flexible array does not occur last in the structure, which
>> will help us prevent some kind of undefined behavior bugs from being
>> inadvertently introduced[3] to the codebase from now on.
>>
>> Also, notice that, dynamic memory allocations won't be affected by
>> this change:
>>
>> "Flexible array members have incomplete type, and so the sizeof operator
>> may not be applied. As a quirk of the original implementation of
>> zero-length arrays, sizeof evaluates to zero."[1]
>>
>> sizeof(flexible-array-member) triggers a warning because flexible array
>> members have incomplete type[1]. There are some instances of code in
>> which the sizeof operator is being incorrectly/erroneously applied to
>> zero-length arrays and the result is zero. Such instances may be hiding
>> some bugs. So, this work (flexible-array member conversions) will also
>> help to get completely rid of those sorts of issues.
>>
>> This issue was found with the help of Coccinelle.
>>
>> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
>> [2] https://github.com/KSPP/linux/issues/21
>> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> ---
>>   include/linux/can/skb.h |    2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/linux/can/skb.h b/include/linux/can/skb.h
>> index a954def26c0d..900b9f4e0605 100644
>> --- a/include/linux/can/skb.h
>> +++ b/include/linux/can/skb.h
>> @@ -34,7 +34,7 @@
>>   struct can_skb_priv {
>>       int ifindex;
>>       int skbcnt;
>> -    struct can_frame cf[0];
>> +    struct can_frame cf[];
>>   };
>>     static inline struct can_skb_priv *can_skb_prv(struct sk_buff *skb)
>>
> 
> Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> @Gustavo: Just to be sure:
> 
> From the referenced URLs I got the information that the sizeof() operator causes problems when applied to e.g. cf[0].
> 
> We don't have this case in our code - but one question remains to me:
> 
> We are using the above construct to ensure the padding between the two 'int' values and the struct can_frame which enforces a 64 bit alignment.
> 
> This intention is not affected by the patch, right?
> 

pahole shows exactly the same output either if cf is a zero-length array or
a flexible-array member:

$ pahole -C 'can_skb_priv' drivers/net/can/dev.o

struct can_skb_priv {
	int                        ifindex;              /*     0     4 */
	int                        skbcnt;               /*     4     4 */
	struct can_frame           cf[] __attribute__((__aligned__(8))); /*     8     0 */

	/* size: 8, cachelines: 1, members: 3 */
	/* forced alignments: 1 */
	/* last cacheline: 8 bytes */
} __attribute__((__aligned__(8)));

So, it seems everything should fine. :)

Thanks
--
Gustavo
