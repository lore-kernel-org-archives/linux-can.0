From: "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Subject: Re: [PATCH V2 1/1] can: sja1000: f81601: add Fintek F81601 support
Date: Mon, 22 Jul 2019 16:36:53 +0800
Message-ID: <b7c9026a-a887-bc84-3297-c319d18686c3@gmail.com>
References: <1563776521-28317-1-git-send-email-hpeter+linux_kernel@gmail.com>
 <563b0d71-3c60-d32c-cf19-73611f68d45a@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <563b0d71-3c60-d32c-cf19-73611f68d45a@pengutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>, wg@grandegger.com, peter_hong@fintek.com.tw
Cc: davem@davemloft.net, f.suligoi@asem.it, linux-kernel@vger.kernel.org, linux-can@vger.kernel.org, netdev@vger.kernel.org, "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
List-Id: linux-can.vger.kernel.org

Hi Marc,

Marc Kleine-Budde 於 2019/7/22 下午 04:15 寫道:
> On 7/22/19 8:22 AM, Ji-Ze Hong (Peter Hong) wrote: >> +/* Probe F81601 based device for the SJA1000 chips and register each
>> + * available CAN channel to SJA1000 Socket-CAN subsystem.
>> + */
>> +static int f81601_pci_add_card(struct pci_dev *pdev,
>> +			       const struct pci_device_id *ent)
>> +{
>> +	struct sja1000_priv *priv;
>> +	struct net_device *dev;
>> +	struct f81601_pci_card *card;
>> +	int err, i, count;
>> +	u8 tmp;
>> +
>> +	if (pcim_enable_device(pdev) < 0) {
> 
> I'm missing a corresponding disable_device().
> 
I'm using managed pcim_enable_device(), Does it need call
pci_disable_device() ??

Thanks
-- 
With Best Regards,
Peter Hong
