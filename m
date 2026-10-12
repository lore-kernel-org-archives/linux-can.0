Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECA92E2286
	for <linux-can@vger.kernel.org>; Mon, 12 Oct 2026 07:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791790804; cv=none; b=bN4Wuz81NQK04pBCdvE7wfOfzzUC1LoDn0Oq3k9HaF0Sli4WLwHnnltN/yUBY6lSGQk3fjXNmAMPzRvmI0Z3pBlGLSpfEqoYU5+CbG8GTLKz0QeZgexHNTCOqVyEDhTL+qhNNFdN3BSf06iVCQxQTJm+zjDXBbBRIkXNpX0MnE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791790804; c=relaxed/simple;
	bh=1ROz++nxzeSJw9hJvLouiBd1sEKan4/LpKWnB4+vXNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K6Vw0uMjgmuMPi8HUcQ5CcV4Fp3Yck6BvlTU64BzHtVpuMhkJRNKh/IcY2soLtkr1oqE5pCrUMYa+L+Ue0MHM3AWl5rhE+sRGB5ZL8D+Oipw4+HGDCZDdG5pgkQum2wjTj9FHrRCVBgXa7YhAxurYSnlc0SeLw12TlQCa+3I6zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=alexander.hoelzl@gmx.net header.b=Ncejk3VI; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=alexander.hoelzl@gmx.net header.b="Ncejk3VI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1791790794; x=1792395594;
	i=alexander.hoelzl@gmx.net;
	bh=RN/peupoZJcjuQQgPOaj3ZYysJE4/CqRlG0N/BFljJk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Ncejk3VI845RwuXqoDumFguDCfZjPSHb7HzsRPYpGWoLEa0cmmWf3MWc75fB0wKo
	 uNJ228xkUQzmoaOXjZjJVx2xBltKEP7XcKIX0Cp/z6kLL41OfXaNq7ktBH0m/ocdw
	 REPNEFadVofe9kfnM7zIEEb0KNp/BUxnL+6TcWnY2C1BrQFXOgYs1w0HeLvvThE0Y
	 n+i4AVuZUNjbtG4A7V2a4xq7a+JvneEeQKfmGIaLsW8mS7qAM6nmTpeZINJ1hsf96
	 J6lwHfNklQln6Q7++8W6vd3riAQjWuCzX3xw/4D110BZ9bP4k1YEI8ozW2gp0iY/f
	 s+Z2VqQyG9fCvboDcw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MCKBm-1xPYIy2L3a-00BvTp; Mon, 12
 Oct 2026 09:39:54 +0200
Message-ID: <287eb29c-6c38-4259-9e77-9a93084e59a3@gmx.net>
Date: Mon, 12 Oct 2026 09:39:53 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] can: j1939: fix potential race condition in BAM
 segmentation
To: sashiko-reviews@lists.linux.dev
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>,
 Oliver Hartkopp <socketcan@hartkopp.net>
References: <20261011153119.120302-1-alexander.hoelzl@gmx.net>
 <sashiko-outbox-167306@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?H=C3=B6lzl=2C_Alexander?= <alexander.hoelzl@gmx.net>
In-Reply-To: <sashiko-outbox-167306@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Q/vGpLzvRkkUPwxtYr9fv8UWfsmo3mmVJOw0iP9EzOosZRTibM8
 vNwAps5AuaTgbgNnvcZJAiS4cqvgn8m1fYZ2W+oKVv5sOiDqjT5tAHCX/HRTlRT855Ob8z3
 /yqz8XSQHQ4Q7inIiMWydNzE3LyRYZi7BA1Mz9RCjBJwnAlV1W9xgVy+581SpsEHpVRvRTi
 sw+V3E4CbbQV7meFFw+/g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nLyRtc0bMrE=;UNBpeLTW0qn4FIxjtL8tzvzamg8
 ZOedyLcGDyyH2XbHhbtQPVuwnmfq8A1JYUODJRTh+gIItGbAtshtBO6j2dT3VnMnJJvBpRNME
 BQn3bZ5Kxf2yvjWmTHAUt8+sJLbuTwdGsPoNX81pS2IO6CeoXSqn+fT57XLYiuelCEeF7VPVL
 TREbbnpf/Oc/c0u0dmWZuO/ep8TYu8uN0Ue/qI+Rfj92Z8MWIdgWF/HtVU9mtXGUF+MRYdPKm
 zG+sbYY7IF8JkyIbHYGp7koExJo2sn8DlcJpg8cGJ00eSP+ey7/i4Qr19KEigfSLUie/oJHVP
 uoLiTenBuPi1tmdV/GMiH0l5O8IFHUR5wh6cO16p/6a/T0ZZetoVc2aMKPggVzjeSIPiG6mDj
 1ERnwa/VIkk/bxlTs6kumud5uk9xo8log6wlChrnTCmoEorWsd26Le+X8iIO2v9wdTFM/KTxd
 3d3g3MPrFNx+HSCtbZ41tiT8agHiwciQRH0PVlZAncULBQSzxWkoGX6xfys7RC5Kcrx+6w4X5
 gKMZmK4Q5g5lHFFPvr2tJSKy9/zDJLR0m6eXZuCY0zQ/0Wd/otrHgyAAQTUDBSHVzRQKQOC1U
 ZuKT1gVOT3hS2NMfNdFnT5cKKzFKeMsrt6UQKEUhKdmlQpTPf153F5Af3ny6C8kUR2IVXkNVJ
 d+ixqcSRr7hY5aoKaNgkMKS8SbxC7NHhFA37QFAyfBs9NrJIpHorhZ2BT7p+4UZ6uoT9vlchZ
 /KtEjLnwr2FWb8ZdlF76eOaRXNP/fEjwsDNry/mPH7fAImncpD/42Fx35rXZVVHPWtS1dFDBM
 VKlKIdl9mbGpanE83aNPrHdTlSiklehmW62CjS6olmaZ4IQHaeUxsynuMq2K1AyARfa6ur4+1
 yDlnWL0vqwwBNexRMXvPhnMU43THduDz/ufuMuO5YypiGL3K8Ybwshal0zPf2XJ/yn4NuntIP
 4yEd9gzYSjBjVfL/1D20PuQ+BZWGEeHOR+TgL6ombe0f1oDXkXlgWoZdAL4zTzyxUhq1wSqzl
 OpaIVNrT6KUXM/+VsEdzGIJdW7IMgLcdMrzeGtPHVQWUP85W4BHVSgOwCPENdpTlXRYEGUcPx
 cW8ArPyCnwNXYB+H0uRPn8RGb8X2hlbfiKU8FPLgXnCCYdZxZec5MMK8gNlX5LbdbeIqORd/b
 uOdXELX5cUKwzX9MkuXysfmzyaVVYhKc5GiAz7M7gtk05svbQ+LylKYZUFXXmGcUB2CS44UyG
 qdh8H3f5K/wbMHPD2JtH/IDTMRwY58ByclPq1ow5hejtJLG7Sh1b+dMF4mXRlFv8XOKegG3bb
 WlWca0gZNRTVucSwndp0oGad6U/LqZTC7Dj4406kTKErdl1iD9TTJtuJXaneUwfAHlVUVUasi
 wMBpMM4p/knTMop5fG+hXVl77SzrNkYgwhdPCFDEjum39b9gHULLe6ftQObfOa0zAabGpTivH
 Q7S4klayYF6D8xHxeiz9DZQhCms2UllW+4tOQa0MSUzT3aBL/seodaVvgl3N2cDsuYCi6asK/
 lXXDriVA/frN+D7Dwu+qto+bvL5WQ23v8B5q362brJkwZMezHfUxgNRdKKrGz6JxqKnQO9TFL
 xjddwKnrk02iKk5zFHJQEsTFklx30ahR6yFzbQscyPiusYAUhGUmXa3M2iSWl8RgT3zK++l9o
 EeS68YMgLNrd/uT7sWe/WdJrSoNTkYCEbxb+mtBx3Bdtv9vLFlX3lzGHPIeAN1fxTKQQfQen6
 oqme6vS7JWl4nmgCM60UaWk7xWOscZENrnW2bW2R4Sn+q/0gTxe6nxN+K+vvSt6j+Nb+aw/hm
 jBJMUjgd/bi8NorRFyxO9r3lGmc/tEgCO8H78liKzO5um7X8ONxWgLsqcN552jwprGDtOIdIy
 2zvAN8UxAj6caSMtcPe6rJBGl/LC2HSFbkLnbYuQUkmW1Hpn494ZYpEvOfF04mZ7J8iSDakew
 hEunGXK/PAE1o/7ZVDIsiYyEisC9AeE0yidc3Tb1FIviKJTPr3Eo37CAWSeHRnWGhyL11YpjB
 TXfjsz2xlfXGrIERdGIgwuTVrdBMVC+UA8f10jLPAPLWafk/dR3mzNpujA6Z1Ojdp+KaeUv/1
 NJNCG7A8xvYONNgivKyElsuTqgb0hIn0Bn5birTZvg8YuX+tEm8LlTeGmZiWWEJCEtT/Hqhat
 2LoX2qFXm4TmCpwOOmqB16JnVM7LTIFefiNOsQiah6EIqXKCKcQoGz+GOPl8FlihLZsE6cFTB
 qSBDhYhP+dkR/2ec2PmjLBvq6ebVWsoWCPc3csRBBBAF3ZSrBeb4oIapdYsn5hbzidauD4bjS
 UdMQp9uaz4/I10zNmyw1OuH32QgmeMVEeVqxQOgwml3T1PHDYAS2qmglzjTGNUgBAYOkem4G/
 dqtlyuMtWn7fvGAtABvHTTV9RS1P1MFGPji0iTv4NGtwpsCC+s8eaYEswSu+Z/gaVyeBLFynd
 xkBihfTJZViBZeWC2JDJxm+We7b9QF2amxv4y4J6WwDNCw2H2NENos/qpj/uUFljBbfCHxyzV
 BSaQA+JV39FUKnU5fBd7V+yAujpuAmpBchf7awwwbdo6GiEPfJMu6gjzIL7ZaEjKRsFydAW0D
 +gjVZgeEgZ2D7CBriNfuLEBK+dTsncSmCmjrGZzTcNI4/mUm0lUh28pUHwbmPHHpF7wmSWajF
 FaJzg2OdupSNSCTvXsz2PkM3e4VWKbpCeuPFePKXn+vI1zE69VWwm+g3mZWLpFWLPfHVHNTPC
 XzePnG4Ul4bMvj87j+dRYRpPnR5msEGYBv0/VzLlGZ3lnD74K4aQF7DUAAZ1z5bSQ21FMoBo6
 /5lxCufD1InUKHmDH68B2dFMvX4BnsjieBOAZ/RD/Omgda2+lKG6uyxyMvzePqOvLMFz3rrYf
 rteGigCHNqFr0h4ExJWBJkDxQFKgvhizD+dPTrz5NomIVhjpUg9gYkgJxud1aoM4A0qSB9e+4
 hWBeKYatVSCVPzifN7+cNfzEw6shE2qGYyuHHkf6FDZ11ogZpXtpYic601hf6qm9zKstYgYGL
 kVIcTOEsAZw6DYW11yfYExEIvwTFVnf65ZbCg8fEplLwtdWe0heLUPwH2QRu5EGnTDUdh9kf/
 obqMd5PnhSxfJnndfaMQdVJ+vq1OvXXIZE6XEcrrylhGDIi6H+8KG6fM2wDu1dGKMSHgsr6BG
 D1MD4M5QvK5RDIO6jcNGZHZYhhyJVMuq2PIzh7M3P5G9+r72X9T5VD3YyEjijL9CJ6RT2wiRv
 VflCx2645IBzij5KksRFvxEI3k9vkJREorCMrxS6LYifTU0eFphpmPqw8LH+L7Kxq7nh5CGK/
 mAWJ/D+8DZUvQgKaAlQK7+in9hPqsE+KvguOUPBA0sEevIIVD8/JYwRVQyAlnA+2lcPdw3LLx
 hYggODCm2ZPAe+1t0o8zI5STGTsu0YUK6sJTZwGODetIziwKw5B4NlWcAa2Wc/m2EtoW8trxr
 cCzRt6RkVV8fsmDDAifT7LDU6mAUUVk7BPADLKhkf5UsmNxxRttFHbnj/fOzrGnNFXipN1JVE
 9ucM5CnUUqtNN2+/VQwSqCPAvf8aaeM7kRpCSU2+q2hq4b8c2zue6jFe+SkddiqSSa8kvbEv4
 wIA9Jx/mOR6wAR0juKE+Nc6/rXnc19PbIJZ2rmHONWPFcYcx2cc7pByKyb9mL0kVbSiDPqFxn
 mmwyEgTsGL/MjQBzXc5x+a/2a8DLSIxLas82I4ARq1W5uBFtXcPkaCUbRjP2zIJHz2b2CW/1Q
 /Gr9pMnCNKUds2S3knVAVzx6xu/cj2kHgj08Ox91ijq0/MPxY0o1Awn7E9ZmkKhYBUs8afPje
 YqzAvX6sClTu2G+ndoOKjJFnaJaZUVbfOFgnVmHSvYYbiGqy9KUbrvAaz8rc6AH8Y5fy7HT50
 M5uESzbsj8tVNcJpsjIoeibDB/BLzylIfCIj4dZOkmkZMTpUDdyT329jCJLnvra8+8n7Qwgcx
 W4zUaTsaXdD6CbfWzXUXCPUD+KlKAX0wK23CS2xH/ZKrWiGNApm4DZ1a4Y5lhBbSjaELHuPw3
 V1BPg3BLT4o89ECZsVjpMIPnQoT2S9QlHQUGfTuadBg4dmLME0Nrm5eRTXwHE3bzcut0bjp9n
 MpVIgakhbiq3UaqfZM2FCQhDAnYIXPZB/EzOub1au801ptUhTBNUXiXNBlca9BHU+dK3zlhKd
 BSJb7ZAmxgDGb4MKfxz+XdQACl1eBu+aF4EyYuvOuZ8LCowkU/ShLXl39wUaNuANk0VVNUAxU
 Bos0k0UjC84Y6xPPcdjNCbCgiaTbRpPtn4QeG85zfQmbwkMZp7Qo4Ynewh4DuqVSTntdwLwU1
 7H1Xw1IbzdHWdRIjLBU7GqP6lz6d/FafSiuWNiqNjyh8l17N6+rA3wdWFaHRTjG/+jqXaBsaD
 unqF/1ngbhd5krs1dR605C+katpf+EtzDxi01LEAmLdCtuLDw0KWRGsANVhiFYr5VZvVSlAqd
 V2aaFpQDYxMF3aZ1WYIMa7ymFWK448iIAAlIxQsEaH7PXU/cibXHZtuQX5IY2AlMeEELkDP1N
 Uj+Zf3hloMdtUzu35p1Gpn1TwZgYZKDH9kUHGOkSOaIPtLJ2hSuMDWcbwiWzHxLNZqIaH318Q
 g8E+5varM3rJUIiGichzXUn2G+IL/OwYRisHZ8pp7I9J6MrFCQBBrQp4aFGP74fF1yqK1w5Cz
 6u4Ys3ijVcTbZ/vnmtF4JrGxtFJnQuWb6JcRBzCJaoYkz17gbmd9EDn6mg8QQMRb1WdDYV5U/
 axK/GXpTFZyRN75RppsjhJEXZ1to8Rl+KrkSl0ocjIp47/d+xmAsBVyodfQfTITtrDu54XL23
 oh/1ttWKXZAFQUDsvaKxDC04fY3oZ81WC+PjPaJPtzvPwwwF+LGGKvOyrbAFmBsFPhgzECknT
 XKbexL6ms/pstiYneFf8SqyBqrz013NzpDqLrBEwmmfgZmkW3mHZqOt6yuXgZQDwwP/Q6BAt4
 jr8fQx2zeRBNy1dYxjVuNpM/FvxW5ZOtMOZgDvsw6QjppZQsa+94/rBHJ7ocpYAXB9qyhqdV9
 W4LJig4CU5gU/jF4ZZn+NhTGTNJCzsgn9gHeQlyVybZYXb+YAd37SP5nxjPfEw9iGclFtOg+C
 uQnnL+CtzsdSEJxU6Y6Q2tKORY7v1jkMSrXNTmJStX+ftR0nXv2uubRU9KEoCz0Y2/Lz0ZEoj
 FuywYSGa1alJ4rrqLQcC/r/7Mba+7yST34g+6US54Sidknp32y/i7qU9JXWR8zLp0SP1VlSX/
 2LS96AbLqcbHMk2VS0M3TzlpI+Qmo9J+bkdzevRWoU6nRQnHYDabUdXmCsW//wD9MoEPPVFOM
 zjlh3cAE7ksiBMy2+fo/GzNDMnPoR5UFVpsKybsXJtHOH2zGlH66Pf6b/c7JdexuUQhwWzz37
 bV5HnWd8+cwhPbb/1lQ0kYbwrodoWj5k7zDc0CH3Y2zMm5DUCN3Mw90vcybW3t1k3hs1wqylW
 KkWJ9S9tIXrxz/BVg/cXPkCf8VjwXtFcyJXpB+18pmAMvJxghwdmefSuYLX8Oozb5VhHBy6Bv
 iJDzBlD7pAa7MNBQ8EAEjEyR/+N6XMB3hr0ucgVA4oKoo9Aukl/QJvHy44XeIv+gsM+2Wxg82
 HT9tmQSeO+BsMRrg5K9iAdqcBSfHts8pwR7jGNm9XfK5VoJhTAnc8QR+PMwMEO1efPVqX72fV
 u6TRmKdVbyqlCOE8u37301+Ox4073HkC/JGrXCPcfTer1NxSs2yJctWw4YGZGsUtOeslFOlqt
 z97KTQRTC2t+zxLcC2M8CI3jp6i/d2zbk6oqYxLTAIoNLoCnxDO6W4mXS3wJXDv2WXWMAE3J8
 xBQJ61PMC8UTEhRtI7uqFnCzD4FRIGxnksiePIhwzfy+ZLnHVHmrJfWpyllrKpf6mSEm0uCFY
 gcuG06yyWnHHDp9IZI8gshkpUe+KI94LREkVtNf/Dfav5chd8PqkHfNT4eOlKfx+gdXsD3gHu
 u10nh8x1sT6Gz+bDOAVFLSPiKVDikSwz85kxwyo/jaz9BA0q18X+AS+/C9of4W/+p5WT9r7zu
 Gxi7/auYenUq1QlgYvM1XmyqJJCfME6yJ+g37eVs8L59kI/mVBra2NKZGwNCsUg9JFEuhQ1uk
 5Zb6x1PRM/32ELKdz+6fv1RIcmIsYYhDv9f9rSa9mjHG74XbAoF/AZTRAJ1RtirxTtONGHQuT
 2upNVzvTkWaC0seRXt+w1mE6dwn7OjudYnmjBMm68QWUdRic+EECMCug3cRkQd2G9HtRFOcxc
 K8ddli2qCsihFzR/8TIwIlsdzL9JklpJVP+OyIz2rDBCoYXhSitmWBQOEFLcKjWTFPLnlHFd2
 SO6OE2vuPpDnUmenF4rBjGbx0R4vdARkklt8jh5p0lYpjEfjVV/MxENaIynLxYCneULuSA5Hh
 bEQ+PH8IpjNc/V0nWyYQEY0UphGiEAvaQx9Y0PeaAHrAodAJW3TA5waJaWbxs/jp4d39fbtm6
 obC3N0/RdqQ1mwk52rUMGF6rPXTvdhL1UwiN/EAxrT1ph7sIbxyJLiCKmWoY7+dlVoWsh8FNg
 AC3YQMEhMhakPbqqj1Ow4GQuditbD74J7MtMSoKxWWvMW9UfTg



Am 11.10.2026 um 17:48 schrieb sashiko-bot@kernel.org:
> Thank you for your contribution! Sashiko AI review found 1 potential iss=
ue(s) to consider:
> - [High] can: j1939: session reference leak on concurrent txtimer schedu=
ling
> --
>=20
> commit 8433158f9fc2fee1a98accad978bba5e01cfc621
> Author: Alexander H=C3=B6lzl <alexander.hoelzl@gmx.net>
>=20
> can: j1939: fix potential race condition in BAM segmentation
>=20
> This patch addresses a race condition in segmented BAM messages by movin=
g
> the tx timer scheduling such that it is scheduled when the tx ack is
> received. This aims to prevent session stalls when a BAM frame is stuck =
and
> fixes the behavior for consecutive data frames.
>=20
>> diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
>> index 8fcfd13e5e6f8..c61a021880c01 100644
>> --- a/net/can/j1939/transport.c
>> +++ b/net/can/j1939/transport.c
> [ ... ]
>> @@ -1961,6 +1974,12 @@ static void j1939_xtp_rx_dat_one(struct j1939_se=
ssion *session,
>>   	} else if (remain) {
>>   		if (!session->transmission)
>>   			j1939_tp_set_rxtimeout(session, 750);
>> +		else if (j1939_cb_is_broadcast(&session->skcb)) {
>> +			/* cancel the txtimer to avoid leaking session references */
>> +			j1939_session_txtimer_cancel(session);
>> +			j1939_tp_schedule_txtimer(session, J1939_TP_BAM_FRAME_SPACING_MS);
>> +			j1939_tp_set_rxtimeout(session, J1939_TP_BAM_ECHO_TIMEOUT_MS);
>> +		}
>>   	} else if (do_cts_eoma) {
>>   		j1939_tp_set_rxtimeout(session, 1250);
>>   		if (!session->transmission)
>>   			j1939_tp_schedule_txtimer(session, 0);
>=20
> [Severity: High]
> Does this do_cts_eoma path leak session references when multiple packets=
 are
> processed rapidly?

This review I don't really know how to react to. This is not code I have=
=20
modified so even if it addresses an existing issue it should not be=20
handled in this commit.> When a receiver session processes data packets=20
in j1939_xtp_rx_dat_one(), it
> evaluates do_cts_eoma =3D true if pkt.rx >=3D pkt.last. Because pkt.last=
 is
> initialized to 0 and never updated for receiver sessions, this condition=
 is
> true for every data packet.
>=20
This is also not a correct statement as pkt.last is updated in=20
j1939_xtp_rx_cts_one even for receiving sessions?> Consequently,=20
j1939_tp_schedule_txtimer(session, 0) is called for every
> packet without first cancelling any pending timer.
>=20
> Since j1939_tp_schedule_txtimer() unconditionally calls
> j1939_session_get(session) before starting the timer, calling it multipl=
e
> times before the timer fires (e.g. in a NAPI batch) will re-arm the time=
r
> and leak the extra references, as the timer callback only drops a single
> reference.
>=20
> Should this path also call j1939_session_txtimer_cancel(session) first,
> similar to the new block added above for remain?
>=20
>>   	} else {
>=20


