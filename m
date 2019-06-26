From: Sean Nyekjaer <sean@geanix.com>
Subject: Re: [PATCH] can: mcp251x: add error check when wq alloc failed
Date: Wed, 26 Jun 2019 08:26:03 +0200
Message-ID: <6a678bc9-648e-e566-9781-2b42a678ed86@geanix.com>
References: <20190625125048.28849-1-houweitaoo@gmail.com>
 <CA+FuTSegsUvPSWX+CZuafSD32Sx+xJmYPiQ92geDNqAe8_JGrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+FuTSegsUvPSWX+CZuafSD32Sx+xJmYPiQ92geDNqAe8_JGrQ@mail.gmail.com>
Content-Language: en-US-large
Sender: linux-kernel-owner@vger.kernel.org
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Weitao Hou <houweitaoo@gmail.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, David Miller <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, allison@lohutok.net, tglx@linutronix.de, linux-can@vger.kernel.org, Network Development <netdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-can.vger.kernel.org



On 25/06/2019 16.03, Willem de Bruijn wrote:
> On Tue, Jun 25, 2019 at 8:51 AM Weitao Hou <houweitaoo@gmail.com> wrote:
>>
>> add error check when workqueue alloc failed, and remove
>> redundant code to make it clear
>>
>> Signed-off-by: Weitao Hou <houweitaoo@gmail.com>
> 
> Acked-by: Willem de Bruijn <willemb@google.com>
> 
Tested-by: Sean Nyekjaer <sean@geanix.com>
