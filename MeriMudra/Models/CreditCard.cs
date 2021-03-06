﻿using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace MeriMudra.Models
{
    [Table("CreditCard")]
    public class CreditCard
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]

        public int CardId { get; set; }

        [DisplayName("Bank")]
        public int BankId { get; set; }

        [DisplayName("Bank")]
        [ForeignKey("BankId")]

        public virtual Bank Bank { get; set; }

        [DisplayName("Card Name")]
        public string CardName { get; set; }

        [DisplayName("Card Description")]
        public string CardDescription { get; set; }

        [DisplayName("Card Image Url")]
        public string CardImageUrl { get; set; }
    }
}