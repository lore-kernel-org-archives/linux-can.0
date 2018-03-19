From: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Subject: Re: [bug, bisected] pfifo_fast causes packet reordering
Date: Mon, 19 Mar 2018 13:56:47 +0100
Message-ID: <5468f8eb-17b6-9000-ab4d-a2c67ef35e4b@theobroma-systems.com>
References: <946dbe16-a2eb-eca8-8069-468859ccc78d@theobroma-systems.com>
 <CAA93jw5FSbvg8AZ=EmneW8juqd8LCgp=xUrSxYm2GBEucKkT3w@mail.gmail.com>
 <95844480-d020-9000-53ef-0da8b965ce6e@gmail.com>
 <3a959e50-8656-5d9c-97b9-227d733948f8@theobroma-systems.com>
 <5aeb54ba-2d96-4ab5-53c4-2d3691be7acc@gmail.com>
 <340a6c54-6031-5522-98f5-eafdd3a37a38@theobroma-systems.com>
 <1521462750.3059.12.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1521462750.3059.12.camel@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Paolo Abeni <pabeni@redhat.com>, John Fastabend <john.fastabend@gmail.com>, Dave Taht <dave.taht@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Martin Elshuber <martin.elshuber@theobroma-systems.com>
List-Id: linux-can.vger.kernel.org

On 19.03.18 13:32, Paolo Abeni wrote:
> Is not clear to me if you can reproduce the bug with the vanilla
> kernel, or if  you need some out-of-tree nic driver. Can you please
> clarify which NIC/driver are you using?

Yes I reproduced it with a vanilla kernel. I use two off-the-shelf USB 
NICs, lsusb says:

   Bus 005 Device 013: ID 0b95:7720 ASIX Electronics Corp. AX88772
   Bus 005 Device 014: ID 0b95:772b ASIX Electronics Corp. AX88772B

Photo of the setup:
https://github.com/jakob-tsd/pfifo_stress/blob/master/usb_nics.jpg

Best regards,
Jakob
