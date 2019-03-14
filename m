From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH 4/4] leds: netdev trigger: allow setting initial values in
 device tree
Date: Thu, 14 Mar 2019 12:26:38 +0100
Message-ID: <6fb71b90-1ae3-9d93-6e0c-c95e441ced7a@rasmusvillemoes.dk>
References: <20190311144227.GA4404@amd>
 <20190313202615.22883-1-linux@rasmusvillemoes.dk>
 <20190313202615.22883-5-linux@rasmusvillemoes.dk>
 <20190314102911.GA15173@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190314102911.GA15173@amd>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-can@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-can.vger.kernel.org

On 14/03/2019 11.29, Pavel Machek wrote:
> On Wed 2019-03-13 21:26:15, Rasmus Villemoes wrote:
>> It can be quite convenient to initialize a netdev-triggered LED with a
>> device name and setting the rx,tx,link properties from device tree,
>> instead of having to do that in an init script in userspace.
>>
>> +                The optional child node netdev can be used to
>> +                configure initial values for the link, rx, tx and
>> +                device_name properties. For example, setting
>> +                linux,default-trigger = "netdev" and adding the child
>> +                node
>> +
>> +                netdev {
>> +                    rx;
>> +                    tx;
>> +                    link;
>> +                    device-name = "can0";
>> +                };
>> +
>> +                can be used to replace 'linux,default-trigger =
>> +                "can0-rxtx"' that relies on the deprecated
>> +                CONFIG_CAN_LEDS.
> 
> I'm sorry, but no, not like this. I see it works for you, only having
> single can device, but it would quickly break with two of them and two
> ethernets are rather common.
> 
> So this will need to be device = <&phandle_of_ethernet_device> or
> something like that. There may be example with usb port triggers.

Huh? I have two CAN devices, and there are two LEDs on the front panel
labeled CAN-A and CAN-B; my device tree nodes for that are

		cana {
			label = "cana:green:activity";
			gpios = <&gpio0 10 0>;
			default-state = "off";
			linux,default-trigger = "netdev";

			netdev {
				rx;
				tx;
				link;
				device-name = "can0";
			};
		};

		canb {
			label = "canb:green:activity";
			gpios = <&gpio0 5 0>;
			default-state = "off";
			linux,default-trigger = "netdev";

			netdev {
				rx;
				tx;
				link;
				device-name = "can1";
			};
		};

and this works just fine. The only change from the old DT is the
addition of the netdev nodes and changing linux,default-trigger from
"can0-rxtx", "can1-rxtx" to both "netdev".

Rasmus
