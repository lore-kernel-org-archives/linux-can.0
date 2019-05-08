From: Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH v11 1/5] can: m_can: Create a m_can platform framework
Date: Wed, 8 May 2019 14:54:56 -0500
Message-ID: <35d179a7-2682-111e-638b-903559f0974a@ti.com>
References: <20190319172651.10012-1-dmurphy@ti.com>
 <8b53474d-9dbf-4b81-defd-1587e022990b@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8b53474d-9dbf-4b81-defd-1587e022990b@pengutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>, wg@grandegger.com, davem@davemloft.net
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

Marc

Thanks for the comments

On 5/8/19 9:35 AM, Marc Kleine-Budde wrote:
> On 3/19/19 6:26 PM, Dan Murphy wrote:
>> Create a m_can platform framework that peripheral
>> devices can register to and use common code and register sets.
>> The peripheral devices may provide read/write and configuration
>> support of the IP.
>>
>> Acked-by: Wolfgang Grandegger <wg@grandegger.com>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> 
> [...]
> 
>> -/* m_can private data structure */
>> -struct m_can_priv {
>> -	struct can_priv can;	/* must be the first member */
>> -	struct napi_struct napi;
>> -	struct net_device *dev;
>> -	struct device *device;
>> -	struct clk *hclk;
>> -	struct clk *cclk;
>> -	void __iomem *base;
>> -	u32 irqstatus;
>> -	int version;
>> -
>> -	/* message ram configuration */
>> -	void __iomem *mram_base;
>> -	struct mram_cfg mcfg[MRAM_CFG_NUM];
>> -};
>> +static u32 m_can_read(struct m_can_priv *priv, enum m_can_reg reg)
>> +{
>> +	if (priv->ops->read_reg)
>> +		return priv->ops->read_reg(priv, reg);
>> +	else
>> +		return -EINVAL;
>> +}
> 
> How do you plan to check the return value here?
> What's the difference between a register value of 0xffffffe9 and
> returning -EINVAL?
> 

Good point.  I could just inline this and return whatever is sent from the callback
and as you said allow a backtrace to happen if read_reg is invalid.

>>  
>> -static inline u32 m_can_read(const struct m_can_priv *priv, enum m_can_reg reg)
>> +static int m_can_write(struct m_can_priv *priv, enum m_can_reg reg, u32 val)
>>  {
>> -	return readl(priv->base + reg);
>> +	if (priv->ops->write_reg)
>> +		return priv->ops->write_reg(priv, reg, val);
>> +	else
>> +		return -EINVAL;
>>  }
> 
> I don't see anyone checking the return value. Better just dereference
> the pointer and the kernel will produce a nice backtrace.
> 
> Same should be done for all read and write variants.
> 

I will need to go through this and see if there is any caller checking the return.  But
I think you are correct.  If thats true I will just change this to a void, inline the function
and allow a backtrace if the callback is null

Dan



> Marc
> 
