From: Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH v10 1/4] can: m_can: Create a m_can platform framework
Date: Tue, 19 Mar 2019 06:29:23 -0500
Message-ID: <455ea343-818a-e647-6315-e8855ca43ad2@ti.com>
References: <20190315170257.12847-1-dmurphy@ti.com>
 <0b9fc85a-25bc-d85e-83c9-bc974e0b44e5@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0b9fc85a-25bc-d85e-83c9-bc974e0b44e5@grandegger.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfgang Grandegger <wg@grandegger.com>, mkl@pengutronix.de, davem@davemloft.net
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

Hello

On 3/19/19 1:24 AM, Wolfgang Grandegger wrote:
> Hello Dan,
> 
> checkpatch still reports one "line over 80 characters".
> 

Yes I saw that one before I submitted I was not happy with how it was to be resolved.
It made the line unreadable I will see how to fix it.

<snip>

>> +
>> +	if (priv->is_peripheral) {
>> +		if (priv->tx_skb) {
>> +			netdev_err(dev, "hard_xmit called while tx busy\n");
>> +			return NETDEV_TX_BUSY;
>> +		}
>> +
>> +		if (priv->can.state == CAN_STATE_BUS_OFF) {
>> +			m_can_clean(dev);
>> +		} else {
> 
> Could you please add a comment here about stopping the queue early. I
> would also mention that an improved version may use an array of tx_skbs
>  to support queueing of outgoing messages.
> 

Ack

>> +			priv->tx_skb = skb;
>> +			netif_stop_queue(priv->net);
>> +			queue_work(priv->tx_wq, &priv->tx_work);
>> +		}
>> +	} else {
>> +		priv->tx_skb = skb;
>> +		return m_can_tx_handler(priv);
>>  	}
>>  
>>  	return NETDEV_TX_OK;
>>  }
> 
> At the next respin, you can then add my
> 
>   Acked-by: Wolfgang Grandegger <wg@grandegger.com>
> 
> to the Patch 1/1, 1/2 and 1/4.
> 
> Thanks for your contribution and patience.
> 

No worries.  I am wrapping up tests on our side and see if there is any customer
feedback on this version.  So far the tests look fine no changes.

I should have v11 out by the end of the week.

Latest cangen data for tcan is below.

bitrate 500000 dbitrate 2000000
cangen can0 -g 0 -i  -f &

    11118 transmitted frames (TXF)                                                                                                                                
    11118 received frames (RXF)                                                                                                                                   
        0 matched frames (RXMF)                                                                                                                                   
                                                                                                                                                                  
        0 % total match ratio (RXMR)                                                                                                                              
      442 frames/s total tx rate (TXR)                                                                                                                            
      442 frames/s total rx rate (RXR)                                                                                                                            
                                                                                                                                                                  
        0 % current match ratio (CRXMR)                                                                                                                           
      117 frames/s current tx rate (CTXR)                                                                                                                         
      123 frames/s current rx rate (CRXR)                                                                                                                         
                                                                                                                                                                  
        0 % max match ratio (MRXMR)                                                                                                                               
      498 frames/s max tx rate (MTXR)                                                                                                                             
      488 frames/s max rx rate (MRXR)                                                                                                                             
                                                                                                                                                                  
        0 current receive list entries (CRCV)                                                                                                                     
        0 maximum receive list entries (MRCV)   

> Wolfgang
> 


-- 
------------------
Dan Murphy
