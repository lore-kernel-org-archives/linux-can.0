From: Sean Nyekjaer <sean@geanix.com>
Subject: Re: [PATCH v2 1/2] can: m_can: tcan4x5x: put the device out of
 standby before register access
Date: Mon, 9 Dec 2019 20:52:58 +0100
Message-ID: <a40b5bba-1c8d-7911-bc37-9aab6816e227@geanix.com>
References: <20191209192440.998659-1-sean@geanix.com>
 <78903660-2471-ee36-404b-4c9d2af02fc6@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <78903660-2471-ee36-404b-4c9d2af02fc6@pengutronix.de>
Content-Language: en-US-large
Sender: stable-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>, dmurphy@ti.com, linux-can@vger.kernel.org
Cc: martin@geanix.com, stable@vger.kernel.org
List-Id: linux-can.vger.kernel.org



On 09/12/2019 20.44, Marc Kleine-Budde wrote:
> On 12/9/19 8:24 PM, Sean Nyekjaer wrote:
>> The m_can tries to detect of niso (canfd) is available while in standby,
> 
> What's "of niso"?
> 
Should have been "if niso" :)

Non ISO Operation

0 – CAN FD Frame format according to ISO 11898-1:2015

1 – CAN FD Frame format according to Bosch CAN FD
  Specification V1.0

/Sean
